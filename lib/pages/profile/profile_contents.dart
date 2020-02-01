import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/build_button.dart';
import 'package:dwimay/widgets/loading_widget.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';

/// The profile page. The user logs in using the login page.
/// The details of the user and the QR code for entering will
/// be present after logging in.
/// if the user is not a participant then a qr code will be present
class ProfileContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get the email id of the logged in user
    final String email = User.instance.getEmailID();
    
    // get the clearance level of the logged in user
    final int level = User.instance.getClearanceLevel();

    // returning user UI if level 0 user
    if (level == 0) {
      return Center(
        child: _UserContents(
          email: email,
        ),
      );
    }

    // returning member UI for level 1+ user
    return _MemberContents(
      email: email,
    );
  }
}

/// The contents of the profile page for a level 0 user
class _UserContents extends StatelessWidget {

  /// The email id of the level 0 user
  final String email;

  _UserContents({@required this.email});

  @override
  Widget build(BuildContext context) {

    // size of the QR code
    final double qrCodeSize = MediaQuery.of(context).size.width * 0.7;

    return RegisteredEventsLoader(
      onLoading: LoadingWidget(),
      onLoaded: (BuildContext context, List<String> regEventIds) =>
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              // Title of profile page, along with the logout button
              _TitleAndLogout(email: email,),

              // The title for the QR code
              Text(
                Strings.qrTitle,
                style: Theme.of(context).textTheme.body1,
              ),

              // gap
              SizedBox(height: 30),

              // the QR code
              Flexible(
                child: Center(
                  child: QrImage(
                    // the data being represented as a QR code
                    data: _encrypt(
                      email.substring(0, email.indexOf("@")) + "," + (regEventIds?.join(",") ?? "")
                    ),

                    // the size
                    size: qrCodeSize,

                    // the background color
                    backgroundColor: Colors.white,

                    // TODO: Use fest logo
                    embeddedImage: AssetImage(
                      "assets/images/talk.png",
                    ),

                    // the style of the embedded image
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size.square(qrCodeSize * 0.2),
                    ),
                  ),
                ),
              ),

              // gap
              SizedBox(height: 55,)
            ],
          ),
        ),
    );
  }

  /// function to encrypt a [string]
  String _encrypt(message) {
    var bytes = utf8.encode(message);
    var base64Str = base64.encode(bytes);
    return base64Str;
  }
}


/// The contents of the profile page for a level 1+ user
class _MemberContents extends StatelessWidget {

  /// The email id of the user
  final String email;

  _MemberContents({@required this.email});

  @override
  Widget build(BuildContext context) {
    return EventLoader(
      beginLoad: true,
      onLoading: LoadingWidget(),
      onError: (BuildContext context, dynamic error) =>
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Error occurred. Please try again."),
            backgroundColor: Colors.red
          )
        ),
      onLoaded: (List<Event> events) {
        // getting the matching [Event] object
        Event event = events.firstWhere((event) => event.id == User.instance.getEventId(), orElse: () => null);

        String firstLine;
        String secondLine;
        Widget thumbnail;

        if (User.instance.getClearanceLevel() > 2) {
          firstLine = "You are managing\n";
          secondLine = Strings.festName;
          thumbnail = SvgPicture.asset(
            "assets/svg/fest_logo.svg",
            width: 250
          );
        }

        else if (User.instance.getClearanceLevel() == 2) {
          firstLine = "You are managing the events for\n";
          secondLine = DepartmentExtras.getNameFromId(User.instance.getEventId());
          thumbnail = Image.asset(
            "assets/images/competition.png",
            width: 90,
          );// TODO: Use deparment image
        } 
        else {
          firstLine = "You are managing the event\n";
          secondLine = event.name;
          thumbnail = Image.asset(
            "assets/images/${event.type}.png",
            width: 90,
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Title of profile page, along with the logout button
              _TitleAndLogout(email: email,),

              // something
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // thumbnail
                      thumbnail,

                      // gap
                      SizedBox(height: 20,),

                      // info
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: firstLine,
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontWeight: FontWeight.normal,             
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: secondLine,
                              style:  Theme.of(context).textTheme.headline.copyWith(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                height: 1.5
                              ),
                            )
                          ]
                        ),
                      ),
                    ],
                  )
                ),
              ),

              // gap
              SizedBox(height: 30,),
            ],
          ),
        );
      },
    );
  }
}

/// The title and the logout button
class _TitleAndLogout extends StatelessWidget {

  /// The email id of the user
  final String email;

  _TitleAndLogout({@required this.email});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "Welcome " + email.substring(0, email.indexOf('@')) + "!",
            style: Theme.of(context).textTheme.title,
          ),
        ),

        // logout button
        BuildButton(
          data: Strings.logoutButton,
          onPressed: () {
            BackendProvider.of<AuthBloc>(context).logout();
          },
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ],
    );
  }
}

import 'package:dwimay/strings.dart';
import 'package:dwimay/theme_data.dart';
import 'package:dwimay/widgets/build_button.dart';
import 'package:dwimay/widgets/multiline_subtitle.dart';
import 'package:dwimay/widgets/page_header.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// The contents of the details page
class DetailPageContents extends StatefulWidget {

  /// the height of the header
  final double headerHeight;

  /// The event whose details is to be displayed
  final Event event;

  /// the index to be used to index the current datetime
  final int index;

  /// The hero tag
  final Object heroTag;


  DetailPageContents({@required this.event, @required this.heroTag, @required this.index, @required this.headerHeight});

  @override
  _DetailPageContentsState createState() => _DetailPageContentsState();
}

class _DetailPageContentsState extends State<DetailPageContents> {
  /// The height of the page header thumbnail
  final double thumbnailHeight = 80;

  /// The width of the page header thumbnail
  final double thumbnailWidth = 80;

  /// boolean that defines whether the register button should be 
  /// shown or not
  bool _showRegistrationButton;

  @override
  void initState() {
    super.initState();

    // initializing [_showRegistrationButton]
    if (User.instance.isLoggedIn) {
      if (User.instance.regEventIDs != null && User.instance.regEventIDs.contains(widget.event.id))
        _showRegistrationButton = false;
      else
        _showRegistrationButton = true;
    }
    else {
      _showRegistrationButton = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        // the header card
        PageHeader(
          height: widget.headerHeight,
          title: Text(
            widget.event.name,
            style: Style.titleTextStyle,
          ),

          subtitle: MultilineSubtitle(
            data: [
              MultilineSubtitleData(
                icon: Icons.location_on,
                text: "Venue: " + widget.event.venue
              ),

              MultilineSubtitleData(
                icon: Icons.alarm,
                text: widget.event.formatDate(index: widget.index) + ", " + widget.event.getTime(index: widget.index)
              )
            ],
          ),

          thumbnail: Image.asset(
            "assets/images/${widget.event.type}.png",
            width: thumbnailHeight,
            height: thumbnailWidth,
          ),

          heroTag: widget.heroTag,

          thumbnailHeight: thumbnailHeight,

          thumbnailWidth: thumbnailWidth,
        ),

        // the event overview or decription
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              // gap
              SizedBox(height: 20,),

              // title
              Text(
                Strings.detailsPageTitle,
                style: Style.headerTextStyle,
              ),

              //seperator
              _separator(),

              // event description
              MarkdownBody(
                data: widget.event.description,
                styleSheet: MarkdownStyleSheet(
                  p: Theme.of(context).textTheme.body1,
                ),
              ),

              // gap
              SizedBox(height: 20,),
            ]
            ..add(
              (_showRegistrationButton)
              ? // register button
                BuildButton(
                  data: Strings.registerButton,
                  onPressed: () async {
                    // launching URL in browser
                    if (await canLaunch(widget.event.registrationLink))
                      await launch(widget.event.registrationLink);
                    else
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(Strings.invalidUrl),
                          backgroundColor: Colors.red,
                        )
                      );
                  },
                ) 
              :
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // registered text
                    Text(
                      Strings.registered,
                      style: Style.headerTextStyle.copyWith(
                        color: Colors.grey
                      ),
                    ),

                    // icon
                    SizedBox(width: 20,),

                    // check icon
                    Icon(
                      FontAwesomeIcons.check,
                      color: Colors.grey,
                    )
                  ] 
                )
            ),
          ),
        ),

        // gap
        SizedBox(height: 20,),
      ],
    );
  }

  /// the seperator used to sepertate title from content
  Widget _separator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: new EdgeInsets.symmetric(vertical: 8.0),
          height: 2.0,
          width: 18.0,
          color: new Color(0xff00c6ff),
        )
      ],
    );
  }
}
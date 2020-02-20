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

  /// The pass whose details is to be displayed
  final Pass pass;

  /// If a pass is being represented, The list of all the names of the events 
  /// the pass offers
  final List<String> passEventNames;

  /// the index to be used to index the current datetime
  final int index;

  /// The hero tag
  final Object heroTag;


  DetailPageContents({this.pass, this.event, this.heroTag, this.index, this.passEventNames, @required this.headerHeight}) : 
    assert((event != null) ^ (pass != null),
           "Both pass and event cannot be given at the same time"),
    assert(pass == null || passEventNames != null, 
           "names of events that the pass offers must be given.");

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

  /// Boolean that defines whether a pass is being displayed or an event
  bool _isPass;

  @override
  void initState() {
    super.initState();

    // initializing [_isPass]
    _isPass = widget.pass != null;

    // initializing [_showRegistrationButton]
    if (User.instance.isLoggedIn) {
      if (User.instance.regEventIDs != null && User.instance.regEventIDs.contains(widget.event?.id ?? widget.pass.id))
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
            widget.event?.name ?? widget.pass.name,
            style: Style.titleTextStyle,
          ),

          subtitle: (! _isPass)
          ? MultilineSubtitle(
              data: [
                MultilineSubtitleData(
                  icon: Icons.location_on,
                  text: "Venue: " + widget.event.venue
                ),

                MultilineSubtitleData(
                  icon: Icons.alarm,
                  text: widget.event.formatDate(index: widget.index) + ", " + widget.event.getTime(index: widget.index)
                )
              ]
            )
          : null,

          thumbnail: Image.asset(
            (! _isPass) ? "assets/images/${widget.event.type}.png" : "assets/images/pass.png",
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
                data: widget.event?.description ?? widget.pass.description,
                styleSheet: MarkdownStyleSheet(
                  p: Theme.of(context).textTheme.body1,
                  h1: Style.headerTextStyle,
                  h2: Style.headerTextStyle.copyWith(
                    fontSize: 18
                  )
                ),
              ),

              // gap
              SizedBox(height: 20,),
            ]
            ..addAll(
              (! _isPass && widget.event.type != "competition" && widget.event.speaker != null && widget.event.speaker.length != 0)
              ? [
                  // the speaker
                  Text(
                    Strings.speakerSectionTitle,
                    style: Style.headerTextStyle,
                  ),

                  // separator
                  _separator(),

                  MarkdownBody(
                    data: widget.event.speaker,
                    styleSheet: MarkdownStyleSheet(
                      p: Theme.of(context).textTheme.body1,
                    ),
                  ),

                  // gap
                  SizedBox(height: 20,)
                ]
              : [
                  Container()
                ]
            )
            ..addAll(
              (widget.event!=null && widget.event.getPocName() != "")
              ? [
                  Text(
                    Strings.pocSectionTitle,
                    style: Style.headerTextStyle,
                  ),

                  _separator(),
                  
                  Row(
                    children: <Widget>[
                      FloatingActionButton(
                        child: Icon(FontAwesomeIcons.phoneAlt,),
                        mini: true,
                        // iconSize: 20,
                        onPressed: () async {
                          String phoneNumber = "tel:" + widget.event.getPocNumber();
                          if (await canLaunch(phoneNumber))
                            await launch(phoneNumber);
                          else
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(Strings.callError),
                                backgroundColor: Colors.red,
                              )
                            );
                        },
                      ),

                      SizedBox(width: 10,),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.event.getPocName()
                          ),

                          SizedBox(height: 5,),

                          Text(
                            widget.event.getPocNumber()
                          ),
                        ],
                      ),
                    ],
                  ),
                  

                  SizedBox(
                    height: 20,
                  )
                ]
              : [
                  Container()
                ]
            )
            ..add(
              (_showRegistrationButton)
              ? // register button
                BuildButton(
                  data: Strings.registerButton,
                  onPressed: () async {
                    // launching URL in browser
                    String link = widget.event?.registrationLink ?? widget.pass.registrationLink;
                    if (await canLaunch(link))
                      await launch(link);
                    else
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(Strings.invalidUrl),
                          backgroundColor: Colors.red,
                        )
                      );
                  },
                ) 
              : (
                  (! _isPass)
                  ? Row(
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
                  : 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "EVENTS",
                        style: Style.headerTextStyle,
                      ),

                      // separator
                      _separator(),

                      MarkdownBody(
                        data: "- " + widget.passEventNames.join("\n- "),
                        styleSheet: MarkdownStyleSheet(
                          p: Theme.of(context).textTheme.body1,
                        ),
                      )
                    ]
                  )
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
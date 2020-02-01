import 'package:dwimay/strings.dart';
import 'package:dwimay/theme_data.dart';
import 'package:dwimay/widgets/multiline_subtitle.dart';
import 'package:dwimay/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// The page displaying the details of an event
class DetailPage extends StatefulWidget {

  /// The day of the event, used to get the
  /// correct date and time
  final int day;

  /// The event
  final Event event;

  /// The tag for the hero widget
  final Object heroTag;

  DetailPage({@required this.event, @required this.day, this.heroTag});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  /// The height of the page header thumbnail
  final double thumbnailHeight = 80;

  /// The width of the page header thumbnail
  final double thumbnailWidth = 80;

  /// The height of the graident
  final double gradientHeight = 110;

  /// The height of the header
  final double headerHeight = 170;

  /// The tag for the hero widget
  Object _heroTag;

  @override
  void initState() {
    super.initState();

    // setting the hero tag
    _heroTag = widget.heroTag ?? widget.event;
  }

  @override
  Widget build(BuildContext context) {

    final double gradientStart = MediaQuery.of(context).size.height * 0.20;

    // building the detail page
    return SafeArea(
      child: Scaffold(
        body: Container(
          // expand to fit the device
          constraints: BoxConstraints.expand(),
          // background color
          color: Theme.of(context).backgroundColor,
          child: Stack(
            children: <Widget>[
              // the background image of the detail page
              _buildBackground(context, gradientStart: gradientStart),
              // building the coustom gradient color
              _buildGradient(context, startPos: gradientStart),
              // the content of the detail page
              _buildContent(context, gradientStartPos: gradientStart),
              // the toolbar (back button)
              _buildToolbar(context),
            ],
          ),
        ),
      ),
    );
  }

  /// the background image of the detail page
  Widget _buildBackground(BuildContext context, {@required double gradientStart}) {
    return Container(
      // TODO: use  [Image.asset] instead of network image
      child: Image.network(
        "https://www.sxsw.com/wp-content/uploads/2019/06/2019-Hackathon-Photo-by-Randy-and-Jackie-Smith.jpg",
        fit: BoxFit.cover,
        height: gradientStart + gradientHeight,
        color: Theme.of(context).backgroundColor.withAlpha(128),
        colorBlendMode: BlendMode.hardLight,
      ),
    );
  }

  /// building the background gradient color that covers the bg-image
  Widget _buildGradient(BuildContext context, {@required double startPos}) {
    return Container(
      margin: EdgeInsets.only(top: startPos),
      height: gradientHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            // the transparent color
            Theme.of(context).backgroundColor.withAlpha(0),
            // the main color
            Theme.of(context).backgroundColor,
          ],
          stops: [0.0, 0.9],
          // The offset at which stop 0.0 of the gradient is placed
          begin: FractionalOffset(0.0, 0.0),
          // The offset at which stop 1.0 of the gradient is placed.
          end: FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  /// the seperator used to sepertate title from content
  Widget separator() {
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

  /// the main content of the detail page
  Widget _buildContent(BuildContext context, {@required double gradientStartPos}) {

    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, gradientStartPos + gradientHeight - headerHeight, 20.0, 0.0),
      child: Column(
        children: <Widget>[

          // the header card
          PageHeader(
            height: headerHeight,
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
                  text: widget.event.formatDate(index: widget.day) + ", " + widget.event.getTime(index: widget.day)
                )
              ],
            ),

            thumbnail: Image.asset(
              "assets/images/${widget.event.type}.png",
              width: thumbnailHeight,
              height: thumbnailWidth,
            ),

            heroTag: _heroTag,

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
                separator(),

                // event description
                MarkdownBody(
                  data: widget.event.description,
                  styleSheet: MarkdownStyleSheet(
                    p: Theme.of(context).textTheme.body1,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// building the toolbar
  /// it contains the back button
  Widget _buildToolbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: BackButton(),
    );
  }
}

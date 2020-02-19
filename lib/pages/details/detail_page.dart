import 'dart:math';
import 'package:dwimay/pages/details/detail_page_content.dart';
import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'detail_page_background.dart';

/// The page displaying the details of an event
class DetailPage extends StatefulWidget {

  /// The day of the event, used to get the
  /// correct date and time
  final int day;

  /// The event
  final Event event;

  /// The pass whose details are to be displayed
  final Pass pass;

  /// If a pass is being represented, The list of all the names of the events 
  /// the pass offers. Passed on to [DetailPageContents].
  final List<String> passEventNames;

  /// The tag for the hero widget
  final Object heroTag;

  DetailPage({this.event, this.pass, this.day, this.heroTag, this.passEventNames}) : 
    assert((event != null) ^ (pass != null),
           "Both pass and event cannot be given at the same time"),
    assert(pass == null || passEventNames != null, 
           "names of events that the pass offers must be given.");
  
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

  /// The index of the correct datetime in the list of datetimes
  int _index;

  /// Boolean that defines whether a pass is being displayed or an event
  bool _isPass;

  /// The path for the image to be used for background in [DetailPageBackground]
  String _backgroundPath;

  @override
  void initState() {
    super.initState();

    // setting the hero tag
    _heroTag = widget.heroTag ?? widget.event ?? widget.pass;

    // initializing [_index]
    _index = 0;

    // initializing [_isPass]
    _isPass = widget.pass != null;

    if (! _isPass) {
      // calculating the index of the [datetimes] list 
      // which contain the correct date and time given 
      // the day of the event (which is relative to the)
      // first day of the event
      if (widget.day != null)
        _index = min(widget.event.datetimes.length - 1, widget.day); // used to avoid IndexErrors
      else {
        // identifying the correct index to be used by comparing 'now' with each
        // of the dates in the list of dates
        DateTime now = DateTime.now();
        for (int i = 0; i < widget.event.datetimes.length; i++) {
          if (now.compareTo(widget.event.datetimes[i]) <= 0) {
            _index = i;
            break;
          }
        }
      }
    }

    // initializing [_backgroundPath]
    if (! _isPass) {
      _backgroundPath = "assets/images/events_background.jpg";
    }
    else {
      _backgroundPath = "assets/images/";

      if (widget.pass.name.toLowerCase().contains("homecoming"))
        _backgroundPath += "homecoming_pass.png";
      else if (widget.pass.name.toLowerCase().contains("endgame"))
        _backgroundPath += "endgame_pass.png";
      else if (widget.pass.name.toLowerCase().contains("ultron"))
        _backgroundPath += "ultron_pass.png";
      else if (widget.pass.name.toLowerCase().contains("universe"))
        _backgroundPath += "universe_pass.png";
      else if (widget.pass.name.toLowerCase().contains("multiverse"))
        _backgroundPath += "multiverse_pass.png";
      else if (widget.pass.name.toLowerCase().contains("infinity"))
        _backgroundPath += "infinity_pass.png";
      else
        _backgroundPath += "events_background.jpg";
    }
      
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
              DetailPageBackground(
                gradientStart: gradientStart,
                gradientHeight: gradientHeight,
                backgroundImagePath: _backgroundPath,
              ),

              // the content of the detail page
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, gradientStart + gradientHeight - headerHeight, 20.0, 0.0),
                child: DetailPageContents(
                  event: widget.event,
                  pass: widget.pass,
                  passEventNames: widget.passEventNames,
                  heroTag: _heroTag,
                  headerHeight: headerHeight,
                  index: _index,
                ),
              ),
              
              // the back button
              BackButton(),
            ],
          ),
        ),
      ),
    );
  }
}

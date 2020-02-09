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

  /// The tag for the hero widget
  final Object heroTag;

  DetailPage({@required this.event, this.day, this.heroTag});

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
  int index;

  @override
  void initState() {
    super.initState();

    // setting the hero tag
    _heroTag = widget.heroTag ?? widget.event;

    // initializing index
    index = 0;

    // calculating the index of the [datetimes] list 
    // which contain the correct date and time given 
    // the day of the event (which is relative to the)
    // first day of the event
    if (widget.day != null)
      index = min(widget.event.datetimes.length - 1, widget.day); // used to avoid IndexErrors
    else {
      // identifying the correct index to be used by comparing 'now' with each
      // of the dates in the list of dates
      DateTime now = DateTime.now();
      for (int i = 0; i < widget.event.datetimes.length; i++) {
        if (now.compareTo(widget.event.datetimes[i]) <= 0) {
          index = i;
          break;
        }
      }
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
              ),

              // the content of the detail page
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, gradientStart + gradientHeight - headerHeight, 20.0, 0.0),
                child: DetailPageContents(
                  event: widget.event,
                  heroTag: _heroTag,
                  headerHeight: headerHeight,
                  index: index,
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

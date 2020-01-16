import 'dart:math';

import 'package:dwimay/theme_data.dart';
import 'package:dwimay/widgets/relative_delegate.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

/// The card for the 'per-department' [ListView].
class ListCard extends StatefulWidget {
  /// The event the card represents
  final Event event;

  /// The day. Used to select the correct datetime from
  /// the list of datetimes in the [Event].
  final int day;

  ListCard({@required this.event, @required this.day});

  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {

  @override
  Widget build(BuildContext context) {
    double imageHeight = 80;
    double imageWidth = imageHeight;

    int index = 0;
    if (widget.event.datetimes.length > 1)
      index = min(widget.event.datetimes.length - 1, widget.day); // used to avoid IndexErrors
    
    return SizedBox(
      height: imageHeight * 1.5,
      child: CustomMultiChildLayout(
        delegate: RelativeDelegate(objectCenter: FractionalOffset(0, 0.5)),
        children: <Widget>[
          LayoutId(
            id: Slot.bottom,
            child: _bottomContent(index: index, imageWidth: imageWidth),
          ),

          LayoutId(
            id: Slot.top,
            child: _topContent(imageHeight: imageHeight, imageWidth: imageWidth),
          )
        ],
      ),
    );
  }

  Widget _bottomContent({@required int index, @required double imageWidth}) =>
    Card(
      elevation: 10.0,
      color: Color(0xFF434273),
      child: Padding(
        padding: EdgeInsets.only(left: imageWidth / 2 + 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // gap
            SizedBox(height: 24.0,),

            // event title
            Expanded(
              child: Text(
                widget.event.name,
                style: Style.titleTextStyle,
              ),
            ),

            // separator separating the title and date
            _separator(),

            // contains icon and date
            _eventSubtitle(index: index),
            
            // gap
            SizedBox(height: 14.0,)
          ],
        ),
      ),
    );

  Widget _topContent({@required double imageHeight, @required double imageWidth}) =>
    Hero(
      tag: "${widget.event.id}",
      child: Image.asset(
        "assets/images/${widget.event.type}.png",
        width: imageHeight,
        height: imageWidth,
      ),
    );

  Widget _separator() =>
    Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      height: 2.0,
      width: 18.0,
      color: Color(0xff00c6ff),
    );

  Widget _eventSubtitle({@required int index}) =>
    Row(
      children: <Widget>[
        // timer icon
        Icon(
          Icons.timer,
          size: 12.0,
        ),

        // gap
        SizedBox(
          width: 8.0,
        ),

        // date and time
        Text(
          widget.event.formatDate(index: index) + ", " + widget.event.getTime(index: index),
          style: Style.smallTextStyle,
        ),

        // gap
        SizedBox(
          width: 8.0,
        )
      ],
    );
}

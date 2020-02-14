import 'dart:math';

import 'package:dwimay/pages/details/detail_page.dart';
import 'package:dwimay/theme_data.dart';
import 'package:dwimay/widgets/relative_delegate.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

/// The card for the 'per-department' [ListView].
class ListCard extends StatefulWidget {
  /// The event the card represents
  final Event event;

  /// The pass the card can represent
  final Pass pass;

  /// If a pass is being represented, The list of all the names of the events 
  /// the pass offers. Passed on to [DetailPage]
  final List<String> passEventNames;

  /// The day. Used to select the correct datetime from
  /// the list of datetimes in the [Event].
  final int day;

  /// The hero tag. if [null], the tag will be the [Event] object
  final Object heroTag;

  ListCard({this.event, this.pass, this.day, this.heroTag, this.passEventNames}) :
    assert((event != null) ^ (pass != null),
           "Both pass and event cannot be given at the same time"),
    assert(pass == null || passEventNames != null, 
           "names of events that the pass offers must be given.");


  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {

  /// The height of the thumbnail
  final double imageHeight = 60;

  /// The width of the thumbnail
  final double imageWidth = 60;

  /// The tag for the hero widget
  Object _heroTag;

  /// boolean that defines whether the object in question is a pass or not
  bool _isPass;

  @override
  void initState() {
    super.initState();

    // initializing [_isPass]
    _isPass = widget.pass != null;

    // setting the hero tag
    _heroTag = widget.heroTag ?? (widget.event?.id ?? widget.pass.id) + Random().nextInt(1000).toString();
  }

  @override
  Widget build(BuildContext context) {

    // returning empty container if [event] or [pass] is null
    if ((widget.event == null && ! _isPass) || (widget.pass == null && _isPass))
      return Container();
    
    return GestureDetector(
      child: SizedBox(
        // setting the size of the box
        height: imageHeight * 1.75,

        // positioning the thumbnail at the center left of the bottom 
        // content
        child: CustomMultiChildLayout(
          delegate: RelativeDelegate(objectCenter: FractionalOffset(0, 0.5)),
          children: <Widget>[
            LayoutId(
              id: Slot.bottom,
              child: _bottomContent(),
            ),

            LayoutId(
              id: Slot.top,
              child: _topContent(),
            )
          ],
        ),
      ),

      // when the card is tapped, go to the [DetailPage]
      onTap: () => Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => DetailPage(
            event: widget.event,
            pass: widget.pass,
            passEventNames: widget.passEventNames,
            day: widget.day,
            heroTag: _heroTag,
          ),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
        ),
      )
    );
  }

  /// The bottom content of the card. Consists of the event name
  /// and venue
  Widget _bottomContent() =>
    Card(
      elevation: 10.0,
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
                widget.event?.name ?? widget.pass.name,
                style: Style.titleTextStyle,
              ),
            ),

            // separator separating the title and date
            _separator(),

            // contains venue
            _eventSubtitle(),
            
            // gap
            SizedBox(height: 14.0,)
          ],
        ),
      ),
    );

  /// The top content. Contains the thumbnail image
  Widget _topContent() {
    Image image;
    
    if (! _isPass) {
      image = Image.asset(
        "assets/images/${widget.event.type}.png",
        width: imageHeight,
        height: imageWidth,
      );
    }
    else {
      image = Image.asset(
        "assets/images/pass.png",
        width: imageWidth,
        height: imageHeight,
      );
    }

    return Hero(
      tag: _heroTag,
      child: image
    );
  }

  /// The separator between the event name and the venue
  /// in the card's content.
  Widget _separator() =>
    Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      height: 2.0,
      width: 18.0,
      color: Color(0xff00c6ff),
    );

  /// Formats the venue of the event.
  Widget _eventSubtitle() =>
    (! _isPass)
    ? 
      Row(
        children: <Widget>[
          // timer icon
          Icon(
            Icons.location_on,
            size: 14.0,
          ),

          // gap
          SizedBox(
            width: 8.0,
          ),

          // venue
          Text(
            "Venue: " + widget.event.venue,
            style: Style.smallTextStyle,
          ),

          // gap
          SizedBox(
            width: 8.0,
          )
        ],
      )
  : 
    Container();
}

import 'package:dwimay/theme_data.dart';
import 'package:dwimay/widgets/relative_delegate.dart';
import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';

class PageHeader extends StatelessWidget {
  
  /// The event for which the header has to be created
  final Event event;

  /// The day on which the event is occurring. Used to
  /// get the correct date and time.
  final int day;

  /// The height of the thumbnail
  final double imageHeight = 80;

  /// the width of the thumbnail
  final double imageWidth = 80;
  
  PageHeader({@required this.event, @required this.day});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 170,
      child: CustomMultiChildLayout(
        delegate: RelativeDelegate(objectCenter: FractionalOffset(0.5, 0)),
        children: <Widget>[
          LayoutId(
            id: Slot.bottom,
            child: _bottomContent(),
          ),
          LayoutId(
            id: Slot.top,
            child: _topContent(),
          ), 
        ],
      ),
    );
  }

  /// The content on the top. Consists of the thumbnail
  Widget _topContent() =>
    Hero(
      tag: event,
      child: Image.asset(
        "assets/images/${event.type}.png",
        width: imageHeight,
        height: imageWidth,
      )
    );

  /// The content on the bottom. Consists of the title, venue
  /// and data
  Widget _bottomContent() => 
    Card(
      elevation: 10,
      color: Color(0xFF434273),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // gap
          SizedBox(height: imageHeight / 2 + 10,),

          // title
          Expanded(
            child: Text(
              event.name,
              style: Style.titleTextStyle,
            ),
          ),

          // separator
          _separator(),

          // venue
          _eventSubtitle(icon: Icons.location_on, text: "Venue: " + event.venue),

          // gap
          SizedBox(height: 8,),

          // date and time
          _eventSubtitle(icon: Icons.alarm, text: event.formatDate(index: day) + ", " + event.getTime(index: day)),

          // gap
          SizedBox(height: 20,),
        ],
      ),
    );

  /// this takes a string and icon as input
  /// it is used to add a subtitle to the info card
  Widget _eventSubtitle({@required IconData icon, @required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // alarm icon
        Icon(
          icon,
          size: 14.0,
        ),

        // gap
        SizedBox(
          width: 4.0,
        ),

        // date and time
        Text(
          text,
          style: Style.smallTextStyle,
        ),
      ],
    );
  }

  /// seperator that seperates the title from subtitle
  Widget _separator() {
    return Container(
      margin: new EdgeInsets.symmetric(vertical: 8.0),
      height: 2.0,
      width: 18.0,
      color: new Color(0xff00c6ff),
    );
  }
}

import 'package:dwimay/theme_data.dart';
import 'package:dwimay/widgets/relative_delegate.dart';
import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';

class PageHeader extends StatelessWidget {
  
  final Event event;
  final int day;

  final double imageHeight = 80;
  final double imageWidth = 80;
  
  PageHeader({@required this.event, @required this.day});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
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

  Widget _topContent() =>
    Hero(
      tag: "${event.id}",
      child: Image.asset(
        "assets/images/${event.type}.png",
        width: imageHeight,
        height: imageWidth,
      )
    );

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

          // date and time
          _eventSubtitle(),

          // gap
          SizedBox(height: 20,),
        ],
      ),
    );

  // this takes a string and icon as input
  // it is used to add a subtitle to the info card
  Widget _eventSubtitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // alarm icon
        Icon(
          Icons.alarm,
          size: 12.0,
        ),

        // gap
        SizedBox(
          width: 8.0,
        ),

        // date and time
        Text(
          event.formatDate(index: day) + ", " + event.getTime(index: day),
          style: Style.smallTextStyle,
        ),
      ],
    );
  }

  // seperator that seperates the title from subtitle
  Widget _separator() {
    return Container(
        margin: new EdgeInsets.symmetric(vertical: 8.0),
        height: 2.0,
        width: 18.0,
        color: new Color(0xff00c6ff));
  }
}

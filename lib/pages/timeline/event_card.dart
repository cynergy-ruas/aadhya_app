import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/rendering.dart';
import 'package:dwimay/pages/detail_page.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final bool isLeft;
  static const double height = 80.0;
  static const double width = 140.0;

  const EventCard({Key key, @required this.event, @required this.isLeft})
      : super(key: key);

  @override
  EventCardState createState() => EventCardState();
}

class EventCardState extends State<EventCard> with TickerProviderStateMixin {
  // the main animation controller
  // it when to mave to the animation forward, reverse it or when to stop it
  AnimationController _animationController;

  // this animates the event card
  Animation<double> _cardSizeAnimation;

  //this animates the horizontal line connecting the dot and the card
  Animation<double> _lineAnimation;

  // the initial state
  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 600));
    _cardSizeAnimation = new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(0.0, 0.9, curve: new ElasticOutCurve(0.8)));
    _lineAnimation = new CurvedAnimation(
        parent: _animationController,
        curve: new Interval(0.0, 0.2, curve: Curves.linear));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void runAnimation() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: EventCard.height,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => new Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            // building the horizontal line from the dots to the card
            buildLine(),

            // building the event card
            buildCard(),
          ],
        ),
      ),
    );
  }

  // the max width on either side of the vertical line
  double get maxWidth {
    RenderBox renderBox = context.findRenderObject();
    BoxConstraints constraints = renderBox?.constraints;
    double maxWidth = constraints?.maxWidth ?? 0.0;
    return maxWidth;
  }

  // building the horizontal line
  Widget buildLine() {
    double animationValue = _lineAnimation.value;
    double maxLength = maxWidth - EventCard.width;
    return Align(
        alignment: widget.isLeft ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          height: 2.0,
          width: maxLength * animationValue,
          color: Color.fromARGB(255, 200, 200, 200),
        ));
  }

  // vuilding the event card
  Positioned buildCard() {
    double animationValue = _cardSizeAnimation.value;
    double minOuterMargin = 8.0;
    double outerMargin = minOuterMargin + (1 - animationValue) * maxWidth;
    return Positioned(
      right: widget.isLeft ? null : outerMargin,
      left: widget.isLeft ? outerMargin : null,
      child: Transform.scale(
        scale: animationValue,
        child: Container(width: 140.0, height: 100.0, child: makeCard()),
      ),
    );
  }

  // creating the list tile
  ListTile makeListTile() => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        title: Text(
          widget.event.name,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11.5),
        ),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(
                        event: widget.event,
                      )));
        },
      );

  // making the event card
  Card makeCard() => Card(
        elevation: 8.0,
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: makeListTile(),
        ),
      );
}

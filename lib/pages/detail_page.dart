import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailPage extends StatelessWidget {
  final Event event;
  DetailPage({@required this.event});
  @override
  Widget build(BuildContext context) {
    // building the event price in a small box
    final eventPrice = Container(
      padding: const EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        // TODO: add events price to the Events class in the backend
        // "₹" + event.price.toString(),
        "₹ 200",
        style: TextStyle(color: Colors.white),
      ),
    );

    // all the text content of the first half of the screen
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // gap
        SizedBox(height: 120.0),

        // different icon based on event type
        Icon(
          FontAwesomeIcons.trophy,
          color: Colors.white,
          size: 40.0,
        ),

        // horizontal rule after the icon
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),

        // gap
        SizedBox(height: 10.0),

        // Title
        Text(
          event.name,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),

        // gap
        SizedBox(height: 30.0),

        // subtitle and price
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Text(
                      event.type,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))),
            Expanded(flex: 1, child: eventPrice)
          ],
        ),
      ],
    );

    // the top content text stacked with a back button and a image with a tint
    final topContent = Stack(
      children: <Widget>[
        // bottom most layer of stack
        // it contains image related to the event
        // TODO: change the image atleast department wise
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new NetworkImage(
                    "https://www.sxsw.com/wp-content/uploads/2019/06/2019-Hackathon-Photo-by-Randy-and-Jackie-Smith.jpg"),
                fit: BoxFit.cover,
              ),
            )),

        // give transparent colored container
        // this give sthe background image a tint of the theme color
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),

        // the back or exit button
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    // the content of the bottom half of the screen
    // the decription of the event
    final bottomContentText = Text(
      event.description,
      style: TextStyle(fontSize: 18.0),
    );

    // a registeration button
    // TODO: redirect to the website or payment portal
    final regButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => {},
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("REGISTER", style: TextStyle(color: Colors.white)),
        ));

    // building the bottom 
    // it contains the event description and reg. button
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, regButton],
        ),
      ),
    );

    
    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}

import 'package:dwimay/pages/details/page_header.dart';
import 'package:dwimay/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';

class DetailPage extends StatelessWidget {

  final int index;
  final Event event;

  DetailPage({@required this.event, @required this.index});

  @override
  Widget build(BuildContext context) {

    // building the detail page
    return Scaffold(
      body: Container(
        // expan to fit the device
        constraints: BoxConstraints.expand(),
        // background color
        color: Color(0xFF3E3963),
        child: Stack(
          children: <Widget>[
            // the background image of the detail page
            _buildBackground(),
            // building the coustom gradient color
            _buildGradient(),
            // the content of the detail page
            _buildContent(),
            // the toolbar (back button)
            _buildToolbar(context),
          ],
        ),
      ),
    );
  }

// the background image of the detail page
  Container _buildBackground() {
    return Container(
      // TODO: use  [Image.assets] instead of network image
      child: Image.network(
        "https://www.sxsw.com/wp-content/uploads/2019/06/2019-Hackathon-Photo-by-Randy-and-Jackie-Smith.jpg",
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: new BoxConstraints.expand(height: 295.0),
    );
  }

  // building the background gradient color that covers the bg-image
  Container _buildGradient() {
    return Container(
      margin: EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            // the transperent color
            Color(0x003E3963),
            // the main color
            Color(0xFF3E3963),
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

  // the seperator used to sepertate title from content
  Widget separator() {
    return Container(
        margin: new EdgeInsets.symmetric(vertical: 8.0),
        height: 2.0,
        width: 18.0,
        color: new Color(0xff00c6ff));
  }

  // the main content of the detail page
  Container _buildContent() {
    final _overviewTitle = "Overview".toUpperCase();
    return Container(
      child: ListView(
        padding: EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          // the event info card with vertical icon
          // InfoCard.vertical(event),
          SizedBox(height: 60,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: PageHeader(event: event, day: index,),
          ),

          SizedBox(height: 20,),
          // the event overview or decription
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // title
                Text(
                  _overviewTitle,
                  style: Style.headerTextStyle,
                ),
                //seperator
                separator(),
                // event description
                Text(
                  event.description,
                  style: Style.commonTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // building the toolbar
  // it contains the back button
  Container _buildToolbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: BackButton(color: Colors.white),
    );
  }
}

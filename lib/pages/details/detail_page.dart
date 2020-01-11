import 'package:dwimay/pages/details/info_card.dart';
import 'package:dwimay/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';

class DetailPage extends StatelessWidget {
  Event event;
  DetailPage({@required this.event});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Color(0xFF3E3963),
      child: Stack(
        children: <Widget>[
          _buildBackground(),
          _buildGradient(),
          _buildContent(),
          _buildToolbar(context),
        ],
      ),
    );
  }

  Container _buildBackground() {
    return Container(
      child: Image.network(
        "https://www.sxsw.com/wp-content/uploads/2019/06/2019-Hackathon-Photo-by-Randy-and-Jackie-Smith.jpg",
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: new BoxConstraints.expand(height: 295.0),
    );
  }

  Container _buildGradient() {
    return Container(
      margin: EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0x003E3963),
            Color(0xFF3E3963),
          ],
          stops: [0.0, 0.9],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget separator() {
    return Container(
        margin: new EdgeInsets.symmetric(vertical: 8.0),
        height: 2.0,
        width: 18.0,
        color: new Color(0xff00c6ff));
  }

  Container _buildContent() {
    final _overviewTitle = "Overview".toUpperCase();
    return Container(
      child: ListView(
        padding: EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          InfoCard.vertical(event),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _overviewTitle,
                    style: Style.headerTextStyle,
                  ),
                  separator(),
                  Text(
                    event.description,
                    style: Style.commonTextStyle,
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Container _buildToolbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: BackButton(color: Colors.white),
    );
  }
}

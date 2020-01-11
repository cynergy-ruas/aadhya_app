import 'package:dwimay/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:dwimay/pages/details/detail_page.dart';

class InfoCard extends StatelessWidget {
  Event event;
  final bool horizontal;
  InfoCard(this.event, {this.horizontal = true});
  InfoCard.vertical(this.event) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    final eventThumbnail = Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      alignment:
          horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: Hero(
        tag: "${event.id}",
        child: Image(
          image: AssetImage("${event.type}.png"),
          height: 92.0,
          width: 92.0,
        ),
      ),
    );

    Widget _eventSubtitle({String value, IconData icon}) {
      return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 12.0,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              value,
              style: Style.smallTextStyle,
            ),
          ],
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

    final eventCardContent = Container(
      margin: EdgeInsets.fromLTRB(
          horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 4.0,
          ),
          Text(
            event.name,
            style: Style.titleTextStyle,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            event.venue,
            style: Style.commonTextStyle,
          ),
          separator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: horizontal ? 1 : 0,
                child: _eventSubtitle(
                    value: "${event.datetime}", icon: Icons.timer),
              ),
              SizedBox(
                width: horizontal ? 8.0 : 32.0,
              ),
            ],
          ),
        ],
      ),
    );

    final eventCard = Container(
      child: eventCardContent,
      height: horizontal ? 125.0 : 155.0,
      margin:
          horizontal ? EdgeInsets.only(left: 46.0) : EdgeInsets.only(top: 72.0),
      decoration: BoxDecoration(
        color: Color(0xFF434273),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: horizontal
          ? () => Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => DetailPage(
                    event: event,
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                ),
              )
          : null,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
            eventCard,
            eventThumbnail,
          ],
        ),
      ),
    );
  }
}

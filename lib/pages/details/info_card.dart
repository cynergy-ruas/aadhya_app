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
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    // the event thumbnail(icon)
    // it changes based on the event type
    final eventThumbnail = Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      // alignment changes based on the value of horizontal
      // if horizontal is true then align centerLeft
      // if horizontal is false then align center
      alignment:
          horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,

      // hero gives the icon a animation when it
      // transisions from event page to detail page
      child: Hero(
        // tag is to identify which icon animates
        tag: "${event.id}",
        child: Image(
          image: AssetImage("assets/images/${event.type}.png"),
          height: deviceHeight * 0.115,
          width: deviceHeight * 0.115,
        ),
      ),
    );

    // this takes a string and icon as input
    // it is used to add a subtitle to the info card
    Widget _eventSubtitle({String value, IconData icon}) {
      return Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
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

    // seperator that seperates the title from subtitle
    Widget separator() {
      return Container(
          margin: new EdgeInsets.symmetric(vertical: 8.0),
          height: 2.0,
          width: 18.0,
          color: new Color(0xff00c6ff));
    }

    // the content of the card
    final eventCardContent = Container(
      margin: EdgeInsets.fromLTRB(
          horizontal ? deviceWidth * 0.185 : deviceWidth * 0.039,
          horizontal ? deviceHeight * 0.02 : deviceHeight * 0.153,
          deviceWidth * 0.039,
          deviceHeight * 0.02),
      // constraints: BoxConstraints.expand(),
      child: Column(
        // alignment changes based on the value of horizontal
        // if horizontal is true then align start
        // if horizontal is false then align center
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          // gap
          SizedBox(
            height: 4.0,
          ),
          // event title
          Text(
            event.name,
            style: Style.titleTextStyle,
          ),
          // event venue
          Text(
            event.venue,
            style: Style.commonTextStyle,
          ),
          // seperator
          separator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // date and time of event
              Expanded(
                flex: horizontal ? 1 : 0,
                child: _eventSubtitle(
                    value: event.formatDate() + ", " + event.getTime(),
                    icon: Icons.timer),
              ),
              // gap
              SizedBox(
                width: horizontal ? 8.0 : 32.0,
              ),

              /// add more [_eventSubtitle] here
            ],
          ),
        ],
      ),
    );

    // the event card with the content
    final eventCard = Card(
      elevation: 10.0,
      child: eventCardContent,
      color: Color(0xFF434273),
    );

    // returning the card with content and the thumbnail.
    // the info card is wrapped in a gesture detector
    // if horizonatl is true, i.e it is in the event page, then
    // on tap redirect to the detail page
    // else it is already on the detail page so do nothing.
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

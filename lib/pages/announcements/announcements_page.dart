import 'package:dwimay/strings.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

import 'announcements_card.dart';

/// Displays all the announcements/notifications
class AnnouncementsPage extends StatefulWidget {
  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            // title
            Text(
              Strings.announcementsPageTitle,
              style: Theme.of(context).textTheme.title,
            ),

            // gap
            SizedBox(height: 20,),

            // subtitle
            Text(
              Strings.announcementsPageSubtitle,
            ),

            // gap
            SizedBox(height: 40,),

            Expanded(
              child: AnnouncementsBuilder(
                builder: (BuildContext context, List<Announcement> announcements) {
                  // checking if there are no announcements. If there are none, 
                  // displaying the appropriate text
                  if (announcements.isEmpty)
                    return Center(
                      child: Text(
                        Strings.noAnnouncementsText
                      ),
                    );
                  
                  // displaying the list of announcements
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: announcements.length,
                    itemBuilder: (BuildContext context, int index) =>
                      Dismissible(
                        // giving a key so that everything works
                        key: ValueKey(announcements[index]),

                        // setting the direction that can be dismissed from
                        direction: DismissDirection.endToStart,

                        // widget
                        child: AnnouncementCard(announcement: announcements[index],),

                        // the background, a trash symbol with a red background
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          padding: EdgeInsets.only(right: 20),
                          child: Icon(Icons.delete, color: Colors.white,),
                        ),

                        // action to perform when item is dismissed
                        onDismissed: (DismissDirection direction) =>
                          NotificationsListener.of(context).delete(index: index),
                      ),
                  );
                }
              )
            ),
            
            // gap
            SizedBox(height: 115,)
          ],
        ),
      ),
    );
  }
}

class SubscribeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Subscribe"),
      onPressed: () {
        NotificationsListener.of(context).subscribe(topic: "t12").then((_) =>
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Subscribed to t12"),
            )
          )
        );
      },
    );
  }
}
import 'package:dwimay/pages/announcements/detail_page_wrapper.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

/// The card displaying brief information of an announcement
/// / notification
class AnnouncementCard extends StatelessWidget {

  /// The announcement
  final Announcement announcement;

  /// The index of the announcement
  final int index;

  AnnouncementCard({@required this.announcement, @required this.index});

  @override
  Widget build(BuildContext context) {
    Widget card = Dismissible(
      // giving a key so that everything works
      key: ValueKey(announcement),

      // the dismiss direction
      direction: DismissDirection.endToStart,

      // the actual card
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          title: Text(announcement.title),
          subtitle: Text(announcement.body),
        ),
      ),

      // the background (trash symbol behind the card while dismissing)
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white,),
      ),

      // action to perform when item is dismissed
      onDismissed: (DismissDirection direction) =>
        BackendProvider.of<NotificationBloc>(context).removeFromPool(index: index),
    );

    // if the annoucement is related to an event, wrap a [GestureDetector]
    // around it which will go to the [DetailPage] on tap.
    if (announcement.data.containsKey("eventID")) {
      return GestureDetector(
        child: card,
        onTap: () { 
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailPageWrapper(
                eventID: announcement.data["eventID"],
              )
            )
          );

          // removing the announcement from the pool
          BackendProvider.of<NotificationBloc>(context).removeFromPool(index: index);
        }
      );
    }

    return card;
  }
}
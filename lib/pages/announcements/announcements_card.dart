import 'package:dwimay/pages/announcements/detail_page_wrapper.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

/// The card displaying brief information of an announcement
/// / notification
class AnnouncementCard extends StatefulWidget {

  /// The announcement
  final Announcement announcement;

  /// The index of the announcement
  final int index;

  AnnouncementCard({@required this.announcement, @required this.index});

  @override
  _AnnouncementCardState createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {

  /// The controller for the [ExpandableNotifier]
  ExpandableController _controller;

  @override
  void initState () {
    super.initState();

    // initializing the controller
    _controller = ExpandableController();
  }

  @override
  Widget build(BuildContext context) {

    // the widget to return
    Widget card;
    
    // The header of the card
    Widget header = ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      title: Text(widget.announcement.title),
      subtitle: Text(widget.announcement.body),
    );

    // if the annoucement is related to an event update, wrap a [GestureDetector]
    // around it which will go to the [DetailPage] on tap.
    if (widget.announcement.data.containsKey("eventID")) {
      card = GestureDetector(
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: header
        ),

        onTap: () { 
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailPageWrapper(
                eventID: widget.announcement.data["eventID"],
              )
            )
          );

          // removing the announcement from the pool
          BackendProvider.of<NotificationBloc>(context).removeFromPool(index: widget.index);
        }
      );
    }


    
    // If the announcement has extra information that
    // can be viewed, make it expandable
    else {
      card = ExpandableNotifier(
        controller: _controller,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: ExpandablePanel(
            hasIcon: false,
            tapHeaderToExpand: true,
            tapBodyToCollapse: true,
            header: header,
            expanded: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Text(
                widget.announcement.data["description"]
              ),
            ),
          ),
        )
      );
    }

    // returning the card wrapped in a dismissible
    return Dismissible(
      // giving a key so that everything works
      key: ValueKey(widget.announcement),

      // the dismiss direction
      direction: DismissDirection.endToStart,

      // the actual card
      child: card,

      // the background (trash symbol behind the card while dismissing)
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete),
      ),

      // action to perform when item is dismissed
      onDismissed: (DismissDirection direction) {
        BackendProvider.of<NotificationBloc>(context).removeFromPool(index: widget.index);
      }
    );
  }
}
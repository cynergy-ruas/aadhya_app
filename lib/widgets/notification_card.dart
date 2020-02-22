import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

/// Widget that describes how a notification should look like
class NotificationCard extends StatelessWidget {

  /// The data of the notification
  final Announcement announcement;

  NotificationCard({@required this.announcement});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            title: Text(
              announcement.title,
            ),
            subtitle: Text(
              announcement.body,
            ),
          ),
        ),
      ),
    );
  }
}
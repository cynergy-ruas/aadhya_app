import 'package:flutter/material.dart';

/// Widget that describes how a notification should look like
class NotificationCard extends StatelessWidget {

  /// The data of the notification
  final Map<String, dynamic> message;

  NotificationCard({@required this.message});

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
            title: Text(
              message['notification']['title'],
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              message['notification']['body'],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
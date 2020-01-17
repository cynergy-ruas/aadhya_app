import 'package:dwimay/widgets/loading_widget.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

class NotificationDialogContents extends StatefulWidget {

  final bool shouldPublish;
  final BuildContext dialogContext;
  
  final String notificationTitle;
  final String notificationSubtitle;
  final String notificationDescription;
  final String notificationTopic;

  NotificationDialogContents({@required this.shouldPublish, @required this.dialogContext,
  @required this.notificationTopic, @required this.notificationTitle, @required this.notificationSubtitle,
  @required this.notificationDescription});

  @override
  _NotificationDialogContentsState createState() => _NotificationDialogContentsState();
}

class _NotificationDialogContentsState extends State<NotificationDialogContents> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (! widget.shouldPublish)
      return Container(
        child: Text("Are you sure you want to publish this notification?"),
      );

    return FutureBuilder(
      future: FunctionsManager.instance.publishNotification(
        topic: widget.notificationTopic,
        announcement: Announcement.fromRaw(
          title: widget.notificationTitle,
          body: widget.notificationSubtitle,
          data: {
            "description": widget.notificationDescription,
          }
        )
      ),

      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          Future.delayed(Duration(seconds: 3)).then((_) => Navigator.of(context).pop());
        
          return Text(
            "Notification Published"
          );
        }

        if (snapshot.hasError) {
          return Text(
            "Error Publishing Notification, Try again."
          );
        }

        else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              LoadingWidget(),
            ],
          );
        }

      },
    );
  }
}
import 'package:dwimay/pages/notification_publisher/publishing_form.dart';
import 'package:dwimay/widgets/loading_widget.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

import 'notification_dialog_contents.dart';

class NotificationPublisher extends StatefulWidget {

  final void Function() onBackPressed;

  final GlobalKey<PublishingFormState> formKey;

  NotificationPublisher({@required this.onBackPressed}) : 
    formKey = GlobalKey<PublishingFormState>();

  @override
  _NotificationPublisherState createState() => _NotificationPublisherState();
}

class _NotificationPublisherState extends State<NotificationPublisher> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // gap
          SizedBox(height: 20,),

          // title
          Text(
            "Publish Notification",
            style: Theme.of(context).textTheme.title.copyWith(
              color: Colors.white
            ),
          ),

          // gap
          SizedBox(height: 20,),

          // form
          Expanded(
            child: EventLoader(
              beginLoad: true,
              onLoading: LoadingWidget(),
              onError: (BuildContext context, dynamic e) => 
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: ListTile(title: Text("Check your internet connection."))
                  )
                ),
              onLoaded: (List<Event> events) => 
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: PublishingForm(
                    key: widget.formKey,
                    events: events,
                    onSaved: onSaved,
                  ),
                ),
            ),
          ),

          // gap
          SizedBox(height: 10,),

          // back button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // back button
              RaisedButton(
                child: Text("Back"),
                onPressed: widget.onBackPressed,
              ),

              RaisedButton(
                child: Text("Publish"),
                onPressed: () => widget.formKey.currentState.saveForm(),
              )
            ],
          ),

          // gap
          SizedBox(height: 10,),
        ],
      )
    );
  }

  void onSaved(Event event, String title, String subtitle, String description) =>
    _showDialog(event.id, title, subtitle, description);
  

  void _showDialog(String topic, String title, String subtitle, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool _shouldPublish = false;

        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) =>
            AlertDialog(
              title: Text("Publish Notification"),
              content: NotificationDialogContents(
                shouldPublish: _shouldPublish,
                dialogContext: context,
                notificationTopic: topic,
                notificationTitle: title,
                notificationSubtitle: subtitle,
                notificationDescription: description,
              ),
              actions: <Widget>[]
              ..addAll(
                (! _shouldPublish)
                ? [
                  FlatButton(
                    child: Text("Publish"),
                    onPressed: () =>
                      setState(() => _shouldPublish = true),
                  )
                ]
                : []
              )
              ..addAll(
                (! _shouldPublish)
                ? [
                  FlatButton(
                    child: Text("Cancel"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ]
                : []
              ),
              
            )
        );
      }
    );
  }
}
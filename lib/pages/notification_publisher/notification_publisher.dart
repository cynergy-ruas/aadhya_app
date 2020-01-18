import 'package:dwimay/pages/notification_publisher/publishing_form.dart';
import 'package:dwimay/widgets/build_button.dart';
import 'package:dwimay/widgets/confirmation_dialog.dart';
import 'package:dwimay/widgets/loading_widget.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';


/// Widget that takes information from the user and publishes it as
/// a notification.
class NotificationPublisher extends StatefulWidget {

  /// Callback that defines what to do when the back button is pressed
  final void Function() onBackPressed;

  /// The global key for the form.
  final GlobalKey<PublishingFormState> formKey;

  NotificationPublisher({@required this.onBackPressed}) : 
    formKey = GlobalKey<PublishingFormState>();

  @override
  _NotificationPublisherState createState() => _NotificationPublisherState();
}

class _NotificationPublisherState extends State<NotificationPublisher> {
  @override
  Widget build(BuildContext context) {
    return EventLoader(
      beginLoad: true,

      // widget to display when loading
      onLoading: _Contents(
        onBackPressed: widget.onBackPressed,
        formKey: widget.formKey,
        contents: Expanded(
          child: LoadingWidget(),
        ),
      ),

      // action to perform when error
      onError: (BuildContext context, dynamic e) => 
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: ListTile(title: Text("Check your internet connection."))
          )
        ),

      // action performed when loaded
      onLoaded: (List<Event> events) => 
        _Contents(
          onBackPressed: widget.onBackPressed,
          formKey: widget.formKey,
          scrollable: true,
          contents: PublishingForm(
            key: widget.formKey,
            events: events,
            onSaved: onSaved,
          ),
        ),
    );
    
  }

  /// Called when the form is saved
  void onSaved(Event event, String title, String subtitle, String description) =>
    _showDialog(event.id, title, subtitle, description);
  

  /// Shows the confirmation dialog. Upon confirmation, the notification is published.
  void _showDialog(String topic, String title, String subtitle, String description) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ConfirmationDialog(
        title: "Publish Notification",
        future: () => FunctionsManager.instance.publishNotification(
          topic: topic,
          announcement: Announcement.fromRaw(
            title: title,
            body: subtitle,
            data: {
              "description": description,
            }
          )
        )
      )
    );
  }
}

/// The contents of the page
class _Contents extends StatelessWidget {

  /// Callback that defines what to do when back 
  /// button is pressed
  final void Function() onBackPressed;

  /// The contents
  final Widget contents;

  /// The key of the publishing form, used when 
  /// the [contents] is a [PublishingForm]
  final GlobalKey<PublishingFormState> formKey;

  /// Defines whether the widget is scrollable or not
  final bool scrollable;

  _Contents({@required this.onBackPressed, @required this.contents, @required this.formKey, this.scrollable = false});

  @override
  Widget build(BuildContext context) {
    Widget body = Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          // title
          Text(
            "Publish Notification",
            style: Theme.of(context).textTheme.title.copyWith(
              color: Colors.white
            ),
          ),

          // gap
          SizedBox(height: 40,),

          // child
          contents,

          // gap
          SizedBox(height: 10,),

          // back button
          Row(
            children: <Widget>[
              // back button
              SizedBox(
                width: 120,
                child: BuildButton(
                  data: "Back",
                  onPressed: onBackPressed,
                ),
              ),

              // center gap
              Expanded(child: Container(),),

              // the publish button
              SizedBox(
                width: 120,
                child: BuildButton(
                  data: "Publish",
                  onPressed: () => formKey.currentState.saveForm(),
                ),
              ),
            ],
          ),
        ]
      )
    );

    // wrapping [body] inside a [SingleChildScrollView] if it should
    // be scrollable
    if (scrollable) 
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: body,
      );

    return body;
  }
}
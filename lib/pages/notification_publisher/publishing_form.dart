import 'package:dwimay/strings.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

/// The form used to publish a notification.
class PublishingForm extends StatefulWidget {

  final List<Event> events;

  final void Function(Event, String, String, String) onSaved;

  PublishingForm({Key key, @required this.events, @required this.onSaved}) : super(key: key);

  @override
  PublishingFormState createState() => PublishingFormState();
}

class PublishingFormState extends State<PublishingForm> {

  /// The title of the notification
  String _title;

  /// The subtitle of the notification
  String _subtitle;

  /// The description of the notification
  String _description;

  /// The controller used in the auto suggestion
  /// events field
  TextEditingController _eventsController;

  /// The global key for the form
  GlobalKey<FormState> formKey;

  /// The event to send notifications for.
  Event _event;

  @override
  void initState() {
    super.initState();
    
    // sorting the list of events received as parameter
    widget.events.sort((Event a, Event b) => a.name.compareTo(b.name));

    // adding the general topic as an event
    widget.events
    .add(
      Event(
        datetimes: null,
        department: null,
        description: "general channel",
        id: "general",
        name: "General",
        speaker: null,
        type: null,
        venue: null,
      )
    );

    // initializing global key for form
    formKey = GlobalKey<FormState>();

    // initializing the events controller
    _eventsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // title of the field
          Text(
            Strings.titleFieldTitle,
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.white
            ),
          ),

          // gap
          SizedBox(height: 20,),

          // Form field for title
          TextFormField(
            decoration: InputDecoration(hintText: Strings.titleFieldHint),
            style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
            validator: (String value) {
              if (value.length == 0)
                return Strings.titleFieldEmpty;
              return null;
            },
            onSaved: (String value) => _title = value.trim(),
          ),

          // gap
          SizedBox(height: 40,),

          // title of the field
          Text(
            Strings.subtitleFieldTitle,
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.white
            ),
          ),

          // gap
          SizedBox(height: 20,),

          // Form field for substitle
          TextFormField(
            style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
            decoration: InputDecoration(hintText: Strings.subtitleFieldHint),
            validator: (String value) {
              if (value.length == 0)
                return Strings.subtitleFieldEmpty;
              return null;
            },
            onSaved: (String value) => _subtitle = value.trim(),
          ),

          // gap
          SizedBox(height: 40,),

          // title of the field
          Text(
            Strings.detailsFieldTitle,
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.white
            ),
          ),

          // gap
          SizedBox(height: 20,),

          // Form field for description
          TextFormField(
            maxLines: 10,
            style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
            decoration: InputDecoration(
              hintText: Strings.detailsFieldHint,
              contentPadding: EdgeInsets.all(10)
            ),
            onSaved: (String value) => _description = value.trim()
          ),

          // gap
          SizedBox(height: 40,),

          Text(
            Strings.eventsFieldTitle,
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.white
            ),
          ),

          // gap
          SizedBox(height: 20,),

          // Suggestions field for events
          TypeAheadFormField<Event>(
            // configuring the field
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                hintText: Strings.eventsFieldHint,
              ),
              style: Theme.of(context).textTheme.body1.copyWith(
                color: Colors.white,
              ),
              controller: _eventsController
            ),
            
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),

            // used to get the suggestions from the string user has 
            // typed
            suggestionsCallback: (String pattern) =>
              widget.events.where(
                (event) => event.name.toLowerCase().contains(pattern.toLowerCase())
              ).toList(),

            // used to build the UI for each suggestion
            itemBuilder: (BuildContext context, Event suggestion) =>
              ListTile(
                title: Text(suggestion.name),
              ),
            
            // Used to build the UI when no matching suggestion is found
            noItemsFoundBuilder: (BuildContext context) => 
              ListTile(
                title: Text(
                  Strings.noEventsFound,
                  style: TextStyle(color: Colors.grey),
                ),
              ),

            // defines what to do when a suggestion is tapped
            onSuggestionSelected: (Event suggestion) => 
              _eventsController.text = suggestion.name,

            // validator
            validator: (String selected) {
              if (selected.isEmpty) {
                return Strings.eventsFieldEmpty;
              }

              if (widget.events.where((event) => event.name == selected).length == 0) {
                return Strings.notValidEvent;
              }

              return null;
            },

            // defines what to do when the form is saved
            onSaved: (String value) =>
              _event = widget.events.firstWhere((event) => event.name == value),

          ),

          // gap
          SizedBox(height: 40,)
        ],
      ),
    );
  }

  /// validates and saves the form.
  void saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onSaved(_event, _title, _subtitle, _description);
      formKey.currentState.reset();
      _eventsController.text = "";
    }
  }

}
import 'package:dwimay/strings.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

/// The form used to publish a notification.
class PublishingForm extends StatefulWidget {

  final List<Event> events;

  final void Function(String, String, String, String, String) onSaved;

  PublishingForm({Key key, @required this.events, @required this.onSaved}) : super(key: key);

  @override
  PublishingFormState createState() => PublishingFormState();
}

class PublishingFormState extends State<PublishingForm> {

  /// The description of the notification
  String _description;

  /// The global key for the form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// The event to send notifications for.
  Event _event;

  /// The list of events, to store a separate copy
  List<Event> events;

  @override
  void initState() {
    super.initState();
    
    // creating a new copy
    events = List.from(widget.events);

    // adding the general topic as an event
    events
    .add(
      Event(
        poc: {
          "name": "",
          "number": "",
        },
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

    // if the user is a coordinator, setting [_eventid] to the event
    // the coordinator is managing
    if (User.instance.getClearanceLevel() == 1)
      _event = events.firstWhere((event) => event.id == User.instance.claims["eventID"], orElse: () => null);
  }

  @override
  Widget build(BuildContext context) {
    if (_event == null && User.instance.getClearanceLevel() == 1) {
      return Center(
        child: Text(Strings.level1ProfileErrorSubtitle),
      );
    }
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[]
        ..addAll(
          (User.instance.getClearanceLevel() > 1) 
          ? []
          : [
              Text(
                "Publishing notification for: " + _event.name,
                style: Theme.of(context).textTheme.subhead.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 40,),
            ]
        )
        ..addAll(
          [
            // title of the field
            Text(
              Strings.detailsFieldTitle,
              style: Theme.of(context).textTheme.subhead,
            ),

            // gap
            SizedBox(height: 20,),

            // Form field for description
            TextFormField(
              maxLines: 10,
              style: Theme.of(context).textTheme.body1,
              decoration: InputDecoration(
                hintText: Strings.detailsFieldHint,
                contentPadding: EdgeInsets.all(10)
              ),
              onSaved: (String value) => _description = value.trim()
            ),
          ]
        )
        ..addAll(
          (User.instance.getClearanceLevel() > 1)
          ? [
              // gap
              SizedBox(height: 40,),

              Text(
                Strings.notificationsPublishEventsFieldTitle,
                style: Theme.of(context).textTheme.subhead,
              ),

              // gap
              SizedBox(height: 20,),

              EventSuggestionField(
                events: events,
                onSaved: (Event event) => _event = event,
              ),

              // gap
              SizedBox(height: 40,),
            ]
          : [
              SizedBox(height: 40,),
            ]
        ),
      ),
    );
  }

  /// validates and saves the form.
  void saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onSaved(
        _event.id,
        _event.department,
        "Announcement!", // the title of the notification
        "There's an announcement for " +
          (
            (_event.id != "general")
            ? _event.name + " participants"
            : "everyone."
          ), // the subtitle of the notification
        _description
      );
      formKey.currentState.reset();
    }
  }

}

class EventSuggestionField extends StatefulWidget {

  /// The list of events
  final List<Event> events;

  /// Function to call when the form is saved
  final void Function(Event) onSaved;

  EventSuggestionField({@required this.events, @required this.onSaved});

  @override
  _EventSuggestionFieldState createState() => _EventSuggestionFieldState();
}

class _EventSuggestionFieldState extends State<EventSuggestionField> {

  /// The controller used in the auto suggestion
  /// events field
  TextEditingController _eventsController;

  /// The list of events
  List<Event> _events;

  @override
  void initState() {
    super.initState();

    // initializing the events controller
    _eventsController = TextEditingController();

    // filtering events based on clearance level and department being handled by user
    _events = widget.events.where(
      (event) {

        // if the user is a level 3 user or above, include the event
        if (User.instance.getClearanceLevel() > 2)
          return true;

        if (User.instance.getClearanceLevel() == 2 && 
            (User.instance.claims["eventID"] == event.department || 
            (event.department == Department.All.id && User.instance.claims["eventID"] != null) ||
            event.id == "general"))
          return true;

        return false;
      }
    )
    .toList();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<Event>(
      direction: AxisDirection.up,
      // configuring the field
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
          hintText: Strings.eventsFieldHint,
        ),
        style: Theme.of(context).textTheme.body1,
        controller: _eventsController
      ),
      
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),

      // used to get the suggestions from the string user has 
      // typed
      suggestionsCallback: (String pattern) =>
        _events.where(
          (event) => event.name.toLowerCase().contains(pattern.toLowerCase())
        ).toList(),

      // used to build the UI for each suggestion
      itemBuilder: (BuildContext context, Event suggestion) =>
        ListTile(
          title: Text(
            suggestion.name,
            style: TextStyle(color: Colors.black),
          ),
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

        if (_events.where((event) => event.name == selected).length == 0) {
          return Strings.notValidEvent;
        }

        return null;
      },

      // defines what to do when the form is saved
      onSaved: (String value) =>
        widget.onSaved(_events.firstWhere((event) => event.name == value)),

    );
  }
}
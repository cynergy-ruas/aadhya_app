import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class PublishingForm extends StatefulWidget {

  final List<Event> events;

  final void Function(Event, String, String, String) onSaved;

  PublishingForm({Key key, @required this.events, @required this.onSaved}) : super(key: key);

  @override
  PublishingFormState createState() => PublishingFormState();
}

class PublishingFormState extends State<PublishingForm> {

  String _title;
  String _subtitle;
  String _description;
  TextEditingController _eventsController;

  GlobalKey<FormState> formKey;

  Event _event;

  @override
  void initState() {
    super.initState();
    
    // sorting the list of events received as parameter
    widget.events.sort((Event a, Event b) => a.name.compareTo(b.name));

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
            "Title",
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.white
            ),
          ),

          // gap
          SizedBox(height: 20,),

          // Form field for title
          TextFormField(
            decoration: InputDecoration(hintText: "Title of the notification"),
            style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
            validator: (String value) {
              if (value.length == 0)
                return "Title cannot be empty";
              return null;
            },
            onSaved: (String value) => _title = value,
          ),

          // gap
          SizedBox(height: 40,),

          // title of the field
          Text(
            "Subtitle",
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.white
            ),
          ),

          // gap
          SizedBox(height: 20,),

          // Form field for substitle
          TextFormField(
            style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
            decoration: InputDecoration(hintText: "Short, one line description"),
            validator: (String value) {
              if (value.length == 0)
                return "Subtitle cannot be empty";
              return null;
            },
            onSaved: (String value) => _subtitle = value,
          ),

          // gap
          SizedBox(height: 40,),

          // title of the field
          Text(
            "Details",
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.white
            ),
          ),

          // gap
          SizedBox(height: 20,),

          // Form field for substitle
          TextFormField(
            maxLines: 10,
            style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Long description",
              contentPadding: EdgeInsets.all(10)
            ),
            onSaved: (String value) => _description = value 
          ),

          // gap
          SizedBox(height: 40,),

          Text(
            "Event to publish for",
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
                hintText: "The event"
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
                  "No events found.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),

            // defines what to do when a suggestion is tapped
            onSuggestionSelected: (Event suggestion) => 
              _eventsController.text = suggestion.name,

            // validator
            validator: (String selected) {
              if (selected.isEmpty) {
                return "Please select a city";
              }

              if (widget.events.where((event) => event.name == selected).length == 0) {
                return "Please select a valid event";
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
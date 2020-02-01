import 'package:dwimay/strings.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class QrScanForm extends StatefulWidget {

  /// Function to execute when a event is chosen
  final void Function(Event) onSelected;

  /// The list of events to be used in the form
  final List<Event> events;

  QrScanForm({@required this.onSelected, @required this.events});

  @override
  _QrScanFormState createState() => _QrScanFormState();
}

class _QrScanFormState extends State<QrScanForm> {

  /// The controller for the field
  TextEditingController _eventsController;

  /// The list of events to be selected from
  List<Event> _events;

  @override
  void initState() {
    super.initState();

    // initializing
    _eventsController = TextEditingController();
    _events = widget.events.where(
      (event) {
        // if the user is a level 3 or above user
        if (User.instance.getClearanceLevel() > 2)
          return true;
        
        // if the user is a level 2 user, only return the events
        // of that user's department
        if (User.instance.getClearanceLevel() == 2 && 
            (User.instance.getEventId() == event.department || 
            (event.department == Department.All.id && User.instance.getEventId() != null)))
          return true;

        // else return false
        return false; 
      }
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          Strings.qrScanFormEventFieldTitle + ":",
          style: Theme.of(context).textTheme.subhead,
        ),

        // gap
        SizedBox(height: 20,),

        // the suggestion field
        TypeAheadFormField<Event>(
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
            )
            .toList(),

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
          onSuggestionSelected: (Event suggestion) {
            _eventsController.text = suggestion.name;
            widget.onSelected(suggestion);
          },

        ),
      ],
    );
  }
}
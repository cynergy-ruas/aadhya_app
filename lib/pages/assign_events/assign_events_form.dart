import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/text_field_shadow.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

/// The form to assign events to users
class AssignEventsForm extends StatefulWidget {

  /// The function to be called when the form is saved
  final void Function(String, String) onSaved;

  /// The list of events
  final List<Event> events;

  AssignEventsForm({Key key, @required this.onSaved, @required this.events}) : super(key: key);

  @override
  AssignEventsFormState createState() => AssignEventsFormState();
}

class AssignEventsFormState extends State<AssignEventsForm> {
  
  /// The global key for the form
  GlobalKey<FormState> formKey;

  /// The email id
  String _emailid;

  /// The event id
  String _eventid;

  /// Controller for the events field
  TextEditingController _eventsController;

  /// The event names
  List<String> eventNames;

  @override
  void initState() {
    super.initState();

    // initializing form key
    formKey = GlobalKey<FormState>();

    // initializing the controller
    _eventsController = TextEditingController();

    // getting the event names
    eventNames = widget.events.where(
      (event) {
        // if the user is a level 3 or above user
        if (User.instance.getClearanceLevel() > 2)
          return true;
        
        // if the user is a level 2 user, only return the events
        // of that user's department
        if (User.instance.getClearanceLevel() == 2 && 
            (User.instance.claims["eventID"] == event.department || 
            (event.department == Department.All.id && User.instance.claims["eventID"] != null)))
          return true;

        // else return false
        return false; 
      }
    )
    .map((event) => event.name)
    .toList()
    // adding the departments if the user is of a high clearance level
    ..addAll(
      (User.instance.getClearanceLevel() > 2) 
      ? [
          Department.AerospaceAndAutomotive.name,
          Department.All.name,
          Department.ComputerScience.name,
          Department.Design.name,
          Department.ElectricAndElectronics.name,
          Department.Mechanical.name,
        ]
      : []
    );

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            // title of the field
            Text(
              Strings.formEmailTitle,
              style: Theme.of(context).textTheme.subhead.copyWith(
                color: Colors.white
              ),
            ),

            // gap
            SizedBox(height: 20,),

            // Text field for email id
            Container(
              decoration: TextFormFieldShadow(),
              child: TextFormField(
                style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
                decoration: InputDecoration(hintText: Strings.formEmailHint),
                validator: (String value) {
                  if (value.length == 0)
                    return Strings.formEmailEmpty;
                  return null;
                },
                onSaved: (String value) => _emailid = value.trim(),
              ),
            ),

            // gap
            SizedBox(height: 40,),

            // title of the "choose clearance level" section
            Text(
              Strings.eventFormFieldTitle,
              style: Theme.of(context).textTheme.subhead.copyWith(
                color: Colors.white
              ),
            ),

            // gap
            SizedBox(height: 20,),

            // Suggestions field for events
            Container(
              decoration: TextFormFieldShadow(),
              child: TypeAheadFormField<String>(
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
                  eventNames.where(
                    (names) => names.toLowerCase().contains(pattern.toLowerCase())
                  )
                  .toList(),

                // used to build the UI for each suggestion
                itemBuilder: (BuildContext context, String suggestion) =>
                  ListTile(
                    title: Text(suggestion),
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
                onSuggestionSelected: (String suggestion) => 
                  _eventsController.text = suggestion,

                // validator
                validator: (String selected) {
                  if (selected.isEmpty) {
                    return Strings.eventsFieldEmpty;
                  }

                  if (eventNames.where((name) => name == selected).length == 0) {
                    return Strings.notValidEvent;
                  }

                  return null;
                },

                // defines what to do when the form is saved
                onSaved: (String value) =>
                  _eventid = widget.events.firstWhere(
                    (event) => event.name == value,
                    orElse: () => null,
                  )?.id ?? DepartmentExtras.getIdFromName(value),

              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Validates the form, and saves it if it is valid
  void saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onSaved(_emailid, _eventid);
      formKey.currentState.reset();
      _eventsController.text = "";
    }
  }
}
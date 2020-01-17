import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

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

  GlobalKey<FormState> formKey;

  Event _event;

  @override
  void initState() {
    super.initState();
    
    // sorting the list of events received as parameter
    widget.events.sort((Event a, Event b) => a.name.compareTo(b.name));

    // initializing global key
    formKey = GlobalKey<FormState>();
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

          // drop down menu for event
          FormField<Event>(
            builder: (FormFieldState<Event> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // the drop down menu to select the event
                  DropdownButton<Event>(
                    items: _generateItems(),
                    onChanged: (Event value) => setState(() => state.didChange(value)),
                    value: state.value,

                    // the underline
                    underline: Container(
                      height: 1,
                      color: (state.hasError) ? Colors.red : Theme.of(context).accentColor,
                    ),

                    // the hint text
                    hint: Center(
                      child: Text(
                        "Select the event",
                        style: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
                      ),
                    ),

                    // how the selected item should look like
                    selectedItemBuilder: (BuildContext buildContext) => 
                      widget.events.map<Widget>((event) => 
                        Center(
                          child: Text(
                            event.name,
                            style: Theme.of(context).textTheme.body1.copyWith(
                              color: Colors.white
                            ),
                          ),
                        )
                      ).toList()
                  ),
                ]
                
                ..addAll(
                  // the error text, if any
                  (state.hasError) 
                  ? [Text(
                      state.errorText,
                      style: Theme.of(context).textTheme.caption.copyWith(color: Colors.red)
                    )]
                  : []
                ),
              );
            },
            validator: (Event event) {
              if (event == null)
                return "Event cannot be empty";
              return null;
            },
            onSaved: (Event event) => _event = event,
          ),

          // gap
          SizedBox(height: 40,)
        ],
      ),
    );
  }

  List<DropdownMenuItem> _generateItems() {
    return widget.events.map(
      (event) => DropdownMenuItem<Event>(
        child: Text(
          event.name,
          style: Theme.of(context).textTheme.body1,
        ),
        value: event
      )
    ).toList();
  }

  void saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onSaved(_event, _title, _subtitle, _description);
      formKey.currentState.reset();
    }
  }

}
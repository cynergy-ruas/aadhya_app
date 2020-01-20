import 'package:dwimay/pages/clearance_modifier/clearance_radio_group.dart';
import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';

/// The form to modify the clearance levels
class ClearanceModifierForm extends StatefulWidget {

  final void Function(String, int) onSaved;

  ClearanceModifierForm({Key key, @required this.onSaved}) : super(key: key);

  @override
  ClearanceModifierFormState createState() => ClearanceModifierFormState();
}

class ClearanceModifierFormState extends State<ClearanceModifierForm> {
  
  /// The global key for the form
  GlobalKey<FormState> formKey;

  /// The email id
  String _emailid;

  /// The clearance level
  int _clearance;

  @override
  void initState() {
    super.initState();

    // initializing form key
    formKey = GlobalKey<FormState>();
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
              Strings.clearanceFormEmailTitle,
              style: Theme.of(context).textTheme.subhead.copyWith(
                color: Colors.white
              ),
            ),

            // gap
            SizedBox(height: 20,),

            // Text field for email id
            TextFormField(
              style: Theme.of(context).textTheme.body1.copyWith(color: Colors.white),
              decoration: InputDecoration(hintText: Strings.clearanceFormEmailHint),
              validator: (String value) {
                if (value.length == 0)
                  return Strings.clearanceFormEmailEmpty;
                return null;
              },
              onSaved: (String value) => _emailid = value.trim(),
            ),

            // gap
            SizedBox(height: 40,),

            // title of the "choose clearance level" section
            Text(
              Strings.clearanceFormLevelTitle,
              style: Theme.of(context).textTheme.subhead.copyWith(
                color: Colors.white
              ),
            ),

            // gap
            SizedBox(height: 20,),

            // Radio buttons
            ClearanceRadioFormField(
              onSaved: (int value) => _clearance = value,
            )
          ],
        ),
      ),
    );
  }

  /// Validates the form, and saves it if it is valid
  void saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onSaved(_emailid, _clearance);
      formKey.currentState.reset();
    }
  }
}
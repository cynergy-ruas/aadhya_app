import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/text_form_field_prefix.dart';
import 'package:flutter/material.dart';

/// The form that takes the required information to reset the password
/// from the user
class PasswordResetForm extends StatefulWidget {

  /// callback to execute when the form is saved
  final void Function(String) onSaved;

  PasswordResetForm({Key key, @required this.onSaved}) : super(key: key);

  @override
  PasswordResetFormState createState() => PasswordResetFormState();
}

class PasswordResetFormState extends State<PasswordResetForm> {

  /// The key for the form
  GlobalKey<FormState> _formKey;

  /// Variable to hold the email address entered by user
  String _emailid;

  @override
  void initState() {
    super.initState();

    // initializing the form key
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // the title of the field
          Text(
            Strings.passwordResetPageMessage,
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.white
            ),
          ),

          // gap
          SizedBox(height: 20,),

          // The text field
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: Colors.white,
            ),
            decoration: TextFormFieldPrefix(
              hintText: Strings.formEmailHint,
              icon: Icon(Icons.person, color: Colors.white,)
            ),
            validator: (String value) {
              if (value.length == 0)
                return Strings.formEmailEmpty;
              return null;
            },
            onSaved: (String value) => _emailid = value.trim(),
          ),

          // gap
          SizedBox(height: 30,),
        ],
      ),
    );
  }

  /// Saves the form
  void saveForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.onSaved(_emailid);
      _formKey.currentState.reset();
    }
  }
}
import 'package:dwimay/pages/login/password_reset_form.dart';
import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/back_confirm_button_bar.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

class PasswordResetPage extends StatefulWidget {
  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  /// The key for the form
  GlobalKey<PasswordResetFormState> _formKey;

  @override
  void initState() {
    super.initState();

    // initializing the key
    _formKey = GlobalKey<PasswordResetFormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          // the title
          Text(
            Strings.passwordResetPageTitle,
            style: Theme.of(context).textTheme.title.copyWith(
              color: Colors.white
            ),
          ),

          // gap
          SizedBox(height: 20,),

          // The form
          Expanded(
            child: PasswordResetForm(
              key: _formKey,
              onSaved: (String email) => BackendProvider.of<AuthBloc>(context).resetPassword(email: email),
            ),
          ),

          // the back and confirm buttons
          BackConfirmButtonBar(
            onConfirmPressed: () => _formKey.currentState.saveForm(),
            onBackPressed: () => BackendProvider.of<AuthBloc>(context).showLoginForm(),
          ),
          

          // gap
          SizedBox(height: 30,)
        ],
      )
    );
  }
}
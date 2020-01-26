import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/build_button.dart';
import 'package:dwimay/widgets/text_field_shadow.dart';
import 'package:dwimay/widgets/text_form_field_prefix.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  
  /// Variable to store the email id
  String _emailid;

  /// Variable to store the password
  String _password; 

  /// The key for the form
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    // initializing form key
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      alignment: Alignment.center,
      // wrapping the tfs and button in a scroll view
      // so that we can scroll when the keyboard is open
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sign In',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.white,
                  ),
            ),

            // gap
            SizedBox(height: 30.0),

            // the form
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  _buildEmailTF(),

                  SizedBox(height: 30,),

                  _buildPasswordTF()
                ],
              ),
            ),

            // gap
            SizedBox(height: 30,),

            // build forgot password and login
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // forgot password
                InkWell(
                  child: Text(
                    Strings.forgotPassword,
                    style: TextStyle(color: Colors.grey),
                  ),

                  onTap: () => BackendProvider.of<AuthBloc>(context).startResetPassword()
                ),

                // gap
                SizedBox(width: 20,),

                // login button
                Flexible(
                  child: BuildButton(
                    data: Strings.loginButton,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    onPressed: () => saveForm(action: "login")
                  ),
                ),
              ],
            ),

            // gap
            SizedBox(height: 20,),

            // the divider
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // the divider
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),

                // the text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "or",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

                // the divider
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                  )
                ),
              ],
            ),

            // gap
            SizedBox(height: 20,),

            // The register button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BuildButton(
                  data: Strings.registerButton,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  onPressed: () => saveForm(action: "register")
                ),
              ],
            ),

            // gap
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  // saves the form
  void saveForm({@required String action}) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (action == "register")
        BackendProvider.of<AuthBloc>(context).register(
          email: _emailid.trim(),
          password: _password.trim(),
        );
      else
        BackendProvider.of<AuthBloc>(context).login(
          email: _emailid.trim(),
          password: _password.trim(),
        );
      _formKey.currentState.reset();
    }
  }

  // building the email textfield(tf)
  Widget _buildEmailTF() {
    return Container(
      decoration: TextFormFieldShadow(),
      child: TextFormField(
        style: Theme.of(context).textTheme.subhead.copyWith(
          color: Colors.white,
        ),
        textAlign: TextAlign.left,
        keyboardType: TextInputType.emailAddress,
        decoration: TextFormFieldPrefix(
          hintText: Strings.formEmailHint,
          icon: Icon(Icons.person, color: Colors.white,)
        ),
        validator: (String value) {
          if (value.length == 0)
            return Strings.formEmailEmpty;
          return null;
        },
        onSaved: (String value) => _emailid = value,
      ),
    );
  }

  // building the password tf
  Widget _buildPasswordTF() {
    return Container(
      decoration: TextFormFieldShadow(),
      child: TextFormField(
        obscureText: true,
        style: Theme.of(context).textTheme.subhead.copyWith(
          color: Colors.white,
        ),
        decoration: TextFormFieldPrefix(
          hintText: Strings.passwordHint,
          icon: Icon(Icons.lock, color: Colors.white,)
        ),
        validator: (String value) {
          if (value.length == 0)
            return Strings.formPasswordEmpty;
          return null;
        },
        onSaved: (String value) => _password = value,
      ),
    );
  }
}

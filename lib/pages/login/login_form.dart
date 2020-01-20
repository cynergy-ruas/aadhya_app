import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/build_button.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // store the email id
  TextEditingController emailController = TextEditingController();

  //store the password
  TextEditingController passwordController = TextEditingController();

  // the style for the textfields
  final boxDecorationStyle = BoxDecoration(
    // to get a curved border
    borderRadius: BorderRadius.circular(10.0),
    // to give a shadow to the tf
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );

  // building the email textfield(tf)
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // the tf label
        Text(
          'Email',
          style: Theme.of(context).textTheme.body1.copyWith(
                color: Colors.white,
              ),
        ),

        // gap
        SizedBox(height: 10.0),

        // the actual email tf
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              // the prefix icon in the email tf
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
            ),
            controller: emailController,
          ),
        ),
      ],
    );
  }

  // building the password tf
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // password tf label
        Text(
          'Password',
          style: Theme.of(context).textTheme.body1.copyWith(
                color: Colors.white,
              ),
        ),

        // gap
        SizedBox(height: 10.0),

        // the actual password tf
        Container(
          alignment: Alignment.centerLeft,
          // decoration: BoxDecorationStyle,
          height: 60.0,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              // the prefix icon in the password tf
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
            ),
            controller: passwordController,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      // wrapping the tfs and button in a scroll view
      // so that we can scroll when the keyboard is open
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 40.0,
          right: 40.0,
          top: 50.0,
        ),
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

            // building email field
            _buildEmailTF(),

            // gap
            SizedBox(height: 30.0),

            // building password field
            _buildPasswordTF(),

            // build login button
            BuildButton(
              data: Strings.loginButton,
              onPressed: () => BackendProvider.of<AuthBloc>(context).login(
                  email: emailController.text,
                  password: passwordController.text),
              verticalPadding: 25.0,
              horizontalPadding: 0.0,
            ),
          ],
        ),
      ),
    );
  }
}

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

        // the leading icon and the text field
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            // the leading icon
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xff2F3857),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )
              ),
              child: Icon(Icons.person, color: Colors.white,),
            ),

            // the actual email tf
            Flexible(
              child: Container(
                decoration: boxDecorationStyle,
                child: TextFormField(
                  style: Theme.of(context).textTheme.subhead.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    // padding
                    hintText: 'Enter your Email',

                    // The border to display when the InputDecorator is disabled and is not showing an error.
                    disabledBorder: (Theme.of(context).inputDecorationTheme.disabledBorder as OutlineInputBorder).copyWith(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),

                    // The border to display when the InputDecorator is enabled and is not showing an error.
                    enabledBorder:  (Theme.of(context).inputDecorationTheme.enabledBorder as OutlineInputBorder).copyWith(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
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

        // the leading icon and the text field
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // the leading icon
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xff2F3857),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )
              ),
              child: Icon(Icons.lock, color: Colors.white,),
            ),

            // the actual password tf
            Flexible(
              child: Container(
                decoration: boxDecorationStyle,
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  style: Theme.of(context).textTheme.subhead.copyWith(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    // hint text
                    hintText: 'Enter your Password',
                                
                    // The border to display when the InputDecorator is disabled and is not showing an error.
                    disabledBorder: (Theme.of(context).inputDecorationTheme.disabledBorder as OutlineInputBorder).copyWith(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),

                    // The border to display when the InputDecorator is enabled and is not showing an error.
                    enabledBorder: (Theme.of(context).inputDecorationTheme.enabledBorder as OutlineInputBorder).copyWith(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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

            // gap
            SizedBox(height: 30,),

            // build login and register button
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // register button
                Flexible(
                  child: BuildButton(
                    data: Strings.registerButton,
                    verticalPadding: 25.0,
                    onPressed: () => BackendProvider.of<AuthBloc>(context).register(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    ),
                  ),
                ),

                // gap
                SizedBox(width: 40),
              
                // login button
                Flexible(
                  child: BuildButton(
                    data: Strings.loginButton,
                    verticalPadding: 25.0,
                    onPressed: () => BackendProvider.of<AuthBloc>(context).login(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:dwimay/pages/login/password_reset_page.dart';
import 'package:dwimay/pages/profile/profile_page.dart';
import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/services.dart';

import 'login_form.dart';

/// The login page
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // gap
          SizedBox(
            height: 10,
          ),

          // the small horizontal bar which indicates the location
          // to pull the sheet from
          Container(
            height: 5,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),

          // gap
          SizedBox(
            height: 20,
          ),

          Expanded(
            child: LoginWidget(
              bloc: BackendProvider.of<AuthBloc>(context),
              // widget to display when the login process is on going
              onLoading: LoadingWidget(),

              // widget to display when the login process was successful
              onSuccess: ProfilePage(),

              // the login form
              loginForm: LoginForm(),

              // the password reset form
              passwordResetForm: PasswordResetPage(),

              // callback to execute when the password reset is successful
              onPasswordResetSuccess: (BuildContext context) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Password reset email sent."),
                  ),
                );
              },

              // callback to execute when an error occurs during the
              // authentication process
              onError: (BuildContext context, dynamic e) {
                String message; 
                print(e.toString());
                try {
                  // type casting
                  PlatformException err = (e as PlatformException);

                  // customizing message based on error
                  if (err.code == "ERROR_INVALID_EMAIL")
                    message = Strings.invalidEmailMessage;
                  else if (err.code == "ERROR_WRONG_PASSWORD")
                    message = Strings.wrongPasswordMessage;
                  else if (err.code == "ERROR_USER_NOT_FOUND")
                    message = Strings.userNotFoundMessage;
                  else 
                    message = Strings.unknownError;
                } catch (e) {
                  message =  Strings.unknownError;
                }
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:dwimay/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'login_form.dart';
import 'profile_page.dart';

/// The login page
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      // gives a custom gradient color to the page
      // jus remove this container to give it the default theme color
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF222831),
              Color(0xFF222831),
              Color(0xFF25292e),
              Color(0xFF28292b),
            ],
            stops: [0.05, 0.4, 0.7, 0.9],
          ),
        ),
      ),

      Column(
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

              // callback to execute when an error occurs during the
              // authentication process
              onError: (BuildContext context, dynamic e) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ]);
  }
}

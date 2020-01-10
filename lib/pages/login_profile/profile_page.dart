import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

/// The profile page. The user logs in using the profile page.
/// The details of the user and the QR code for entering will
/// be present after logging in.
class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Profile page",
              style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text("Logout"),
              onPressed: () {
                LoginWidget.of(context).logout();
              },
            )
          ]),
    );
  }
}

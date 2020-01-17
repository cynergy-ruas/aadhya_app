import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

class ProfileContents extends StatelessWidget {

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
          ),
        ]
      ),
    );
  }
}
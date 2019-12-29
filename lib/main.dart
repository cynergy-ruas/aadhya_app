import 'package:dwimay/pages/main_page.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotificationProvider(
        
        // configuring callback to run when notification occurs when the
        // app is in foreground.
        onMessage: (BuildContext context, Map<String, dynamic> message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: message['body'],
            )
          );
        },

        // rest of the app
        child: MainPage(),
      )
    );
  }
}
import 'package:dwimay/pages/main_page.dart';
import 'package:dwimay/theme_data.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: dwimayTheme,
        home: NotificationProvider(
          // configuring callback to run when notification occurs when the
          // app is in foreground.
          onMessage: (BuildContext context, Map<String, dynamic> message) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: message['body'],
            ));
          },

          // rest of the app
          child: MainPage(),
        ));
  }
}

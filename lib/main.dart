import 'package:dwimay/pages/main/main_page.dart';
import 'package:dwimay/theme_data.dart';
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
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

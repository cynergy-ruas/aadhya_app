import 'package:dwimay/pages/main/main_page.dart';
import 'package:dwimay/theme_data.dart';
import 'package:dwimay/widgets/notification_card.dart';
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
    return BackendProvider(
      onMessage: (BuildContext context, Map<String, dynamic> message) => 
        NotificationCard(message: message,),

      child: MaterialApp(
        title: 'Flutter Demo',
        theme: dwimayTheme,
        home: MainPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

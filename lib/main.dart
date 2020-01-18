import 'package:dwimay/pages/main/main_page.dart';
import 'package:dwimay/theme_data.dart';
import 'package:dwimay/widgets/notification_card.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: NotificationsListener(
        // configuring callback to run when notification occurs when the
        // app is in foreground.
        onMessage: (BuildContext context, Map<String, dynamic> message) {
          
          // showing notification
          showOverlayNotification((context) => 
            Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.up,
              child: NotificationCard(message: message,),
              onDismissed: (DismissDirection direction) => 
                OverlaySupportEntry.of(context).dismiss(animate: false),
            )
          );
        },

        // the rest of the app
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: dwimayTheme,
          home: MainPage(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

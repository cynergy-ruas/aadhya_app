import 'package:dwimay/pages/login_profile/profile_contents.dart';
import 'package:dwimay/pages/login_profile/tools_fab.dart';
import 'package:dwimay/pages/notification_publisher/notification_publisher.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

/// The profile page. The user logs in using the profile page.
/// The details of the user and the QR code for entering will
/// be present after logging in.
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  Widget _body;

  @override
  void initState() {
    super.initState();

    _body = ProfileContents();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,

      // show the FAB if the user has the appropriate clearance level and if 
      // the current page being shown is the [ProfileContents] page
      floatingActionButton: (User.instance.getClearanceLevel() > 0 && _body.runtimeType == ProfileContents)
        ? ToolsFAB(
          onNotificationCreatorButtonPressed: () {
            setState(() {
              _body = NotificationPublisher(
                onBackPressed: toProfileContents
              );
            });
          },
        )
        : null,

      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500,),
        child: _body,
        switchInCurve: Curves.easeInOutQuart,
        switchOutCurve: Curves.easeInOutQuart,
        transitionBuilder: (Widget child, Animation<double> anim) =>
          SlideTransition(
            position: Tween<Offset>(
              begin: (child.runtimeType == ProfileContents) ? Offset(-1.0, 0) : Offset(1.0, 0),
              end: Offset(0, 0)
            ).animate(anim),
            child: child,
          ),
      ),
    );
  }

  void toProfileContents() =>
    setState(() {
      _body = ProfileContents();
    });
}

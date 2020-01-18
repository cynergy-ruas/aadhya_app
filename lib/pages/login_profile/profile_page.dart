import 'package:dwimay/pages/clearance_modifier/clearance_modifier_page.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:dwimay/pages/login_profile/profile_contents.dart';
import 'package:dwimay/pages/login_profile/tools_fab.dart';
import 'package:dwimay/pages/notification_publisher/notification_publisher.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  /// The widget that stores the body of the profile
  /// page.
  Widget _body;

  @override
  void initState() {
    super.initState();

    // intializing the body to profile contents.
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
          onClearanceModifierButtonPressed: () {
            setState(() {
              _body = ClearanceModifier(
                onBackPress: toProfileContents,
              );
            });
          },
        )
        : null,

      // the body. Enables a user with high clearance level to go to 
      // the appropriate pages using a slide transition
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
      )
    );
  }

  void toProfileContents() =>
    setState(() {
      _body = ProfileContents();
    });
}
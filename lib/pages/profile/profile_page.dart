import 'package:dwimay/pages/assign_events/assign_events_page.dart';
import 'package:dwimay/pages/clearance_modifier/clearance_modifier_page.dart';
import 'package:dwimay/pages/profile/user_fab.dart';
import 'package:dwimay/pages/qr_scan/qr_scan_page.dart';
import 'package:dwimay/pages/registered_events/registered_events_page.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'profile_contents.dart';
import 'tools_fab.dart';
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

    Widget fab;

    // show the tools FAB if the user has the appropriate clearance level and if 
    // the current page being shown is the [ProfileContents] page
    if (User.instance.getClearanceLevel() > 0 && _body.runtimeType == ProfileContents) {
      fab = ToolsFAB(
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
        onAssignEventsButtonPressed: () {
          setState(() {
            _body = AssignEvents(
              onBackPress: toProfileContents,
            );
          });
        },
        onQrScanButtonPressed: () {
          setState(() {
            _body = QrScanPage(
              onBackPressed: toProfileContents,
            );
          });
        },
      );
    }

    // showing FAB for user
    else if (User.instance.getClearanceLevel() == 0 && _body.runtimeType == ProfileContents) {
      fab = UserFAB(
        onPressed: () {
          setState(() {
            _body = RegisteredEventsPage(
              onBackPressed: toProfileContents,
            );
          });
        },
      );
    }

    else {
      fab = Container(width: 0, height: 0,);
    }

    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
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

        Positioned(
          right: 20,
          bottom: 20,
          child: fab,
        ),
      ],
    );
  }

  void toProfileContents() =>
    setState(() {
      _body = ProfileContents();
    });
}
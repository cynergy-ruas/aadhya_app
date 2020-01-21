import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicorndial/unicorndial.dart';

class ToolsFAB extends StatelessWidget {

  final void Function() onNotificationCreatorButtonPressed;
  final void Function() onClearanceModifierButtonPressed;
  final void Function() onAssignEventsButtonPressed;

  ToolsFAB({
    @required this.onNotificationCreatorButtonPressed,
    @required this.onClearanceModifierButtonPressed,
    @required this.onAssignEventsButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return UnicornDialer(
      backgroundColor: Colors.transparent,
      parentButton: Icon(FontAwesomeIcons.tools),
      childButtons: <UnicornButton> [
        
        // button for notification creator
        UnicornButton(
          currentButton: FloatingActionButton(
            heroTag: "unicorn_notification_creator",
            child: Icon(FontAwesomeIcons.bell),
            mini: true,
            onPressed: onNotificationCreatorButtonPressed,
          ),
        )
      ]
      ..addAll(
        (User.instance.getClearanceLevel() > 1)
        ? [
            // button for clearance modifier
            UnicornButton(
              currentButton: FloatingActionButton(
                heroTag: "unicorn_clearance_modifier",
                child: Icon(
                  FontAwesomeIcons.userCog,
                  size: 20,
                ),
                mini: true,
                onPressed: onClearanceModifierButtonPressed,
              ),
            ),

            // button for assigning events to coordinators / volunteers
            UnicornButton(
              currentButton: FloatingActionButton(
                heroTag: "unicorn_assign_events",
                child: Icon(
                  FontAwesomeIcons.userTag,
                  size: 20
                ),
                mini: true,
                onPressed: onAssignEventsButtonPressed,
              ),
            )     
        ]
        : []
      ),
    );
  }
}
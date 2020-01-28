import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:unicorndial/unicorndial.dart';

class ToolsFAB extends StatelessWidget {

  final void Function() onNotificationCreatorButtonPressed;
  final void Function() onClearanceModifierButtonPressed;
  final void Function() onAssignEventsButtonPressed;
  final void Function() onQrScanButtonPressed;

  ToolsFAB({
    @required this.onNotificationCreatorButtonPressed,
    @required this.onClearanceModifierButtonPressed,
    @required this.onAssignEventsButtonPressed,
    @required this.onQrScanButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: UnicornDialer(
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
          ),

          // button for qr scanner
          UnicornButton(
            currentButton: FloatingActionButton(
              heroTag: "scan_qr",
              child: Icon(MdiIcons.qrcodeScan),
              mini: true,
              onPressed: onQrScanButtonPressed,
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
      ),
    );
  }
}
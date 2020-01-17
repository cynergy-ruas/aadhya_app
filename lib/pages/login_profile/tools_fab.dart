import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicorndial/unicorndial.dart';

class ToolsFAB extends StatelessWidget {

  final void Function() onNotificationCreatorButtonPressed;

  ToolsFAB({@required this.onNotificationCreatorButtonPressed});

  @override
  Widget build(BuildContext context) {
    return UnicornDialer(
      backgroundColor: Colors.transparent,
      parentButton: Icon(FontAwesomeIcons.tools),
      childButtons: <UnicornButton> [
        
        // button for notification creator
        UnicornButton(
          currentButton: FloatingActionButton(
            child: Icon(FontAwesomeIcons.bell),
            mini: true,
            onPressed: onNotificationCreatorButtonPressed,
          ),
        )
      ],
    );
  }
}
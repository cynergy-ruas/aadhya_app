import 'package:flutter/material.dart';

/// The floating action button for level 0 users.
class UserFAB extends StatelessWidget {

  /// The function to execute when the button is pressed
  final void Function() onPressed;

  UserFAB({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Widget fab = FloatingActionButton(
      elevation: 20,
      child: Icon(Icons.calendar_today),
      heroTag: "user_fab",
      onPressed: onPressed,
    );

    // making the FAB draggable so that it can be moved in case
    // it obstructs the QR code
    return Draggable(
      feedback: fab,
      child: fab,
      childWhenDragging: Container(),
    );
  }
}
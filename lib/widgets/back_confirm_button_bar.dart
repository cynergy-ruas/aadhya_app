import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';

import 'build_button.dart';

class BackConfirmButtonBar extends StatelessWidget {
  final void Function() onBackPressed;
  final void Function() onConfirmPressed;

  BackConfirmButtonBar({@required this.onBackPressed, @required this.onConfirmPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // back button
        Flexible(
          child: Container(
            width: double.infinity,
            child: BuildButton(
              data: Strings.backButton,
              padding: const EdgeInsets.symmetric(vertical: 10),
              onPressed: onBackPressed,
            ),
          ),
        ),

        // center gap
        Expanded(child: Container(),),

        // the confirm button
        Flexible(
          child: Container(
            width: double.infinity,
            child: BuildButton(
              data: Strings.confirmButton,
              padding: const EdgeInsets.symmetric(vertical: 10),
              onPressed: onConfirmPressed,
            ),
          ),
        ),
      ],
    );
  }
}
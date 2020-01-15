import 'package:dwimay/theme_data.dart';
import 'package:flutter/material.dart';

/// this build a simple button
/// it takes the [data] - button text,
/// [onPressed] - on pressed function
/// [verticalPadding] - to change the width of button
/// [horizontalPadding] - to change the length of button
class BuildButton extends StatelessWidget {
  final data;
  final void Function() onPressed;
  final verticalPadding;
  final horizotalPadding;
  BuildButton(
      {@required this.data,
      @required this.onPressed,
      @required this.verticalPadding,
      @required this.horizotalPadding});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizotalPadding),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          data,
          style: Style.buttonTextStyle,
        ),
      ),
    );
  }
}

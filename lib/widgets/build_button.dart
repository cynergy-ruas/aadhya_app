import 'package:dwimay/theme_data.dart';
import 'package:flutter/material.dart';

/// this build a simple button
/// it takes the [data] - button text,
/// [onPressed] - on pressed function
/// [verticalPadding] - to change the width of button
/// [horizontalPadding] - to change the length of button
class BuildButton extends StatelessWidget {
  final String data;
  final void Function() onPressed;
  final double verticalPadding;
  final double horizontalPadding;
  BuildButton(
      {@required this.data,
      @required this.onPressed,
      this.verticalPadding = 0.0,
      this.horizontalPadding = 0.0});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
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

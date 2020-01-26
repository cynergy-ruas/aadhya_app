import 'package:dwimay/theme_data.dart';
import 'package:flutter/material.dart';

/// this build a simple button
/// it takes the [data] - button text,
/// [onPressed] - on pressed function
/// [padding] - to change the width and height of the button
/// [borderRadius] - the radius of the button borders
class BuildButton extends StatelessWidget {
  final String data;
  final void Function() onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  BuildButton({
    @required this.data,
    @required this.onPressed,
    this.borderRadius = 10.0,
    this.padding = const EdgeInsets.all(0),
  });
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 5.0,
      onPressed: onPressed,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: Color(0xff2F3857),
      child: Text(
        data,
        style: Style.buttonTextStyle,
      ),
    );
  }
}

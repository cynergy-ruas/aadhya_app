import 'package:flutter/material.dart';

class Animated_Icon extends AnimatedWidget {
  Animated_Icon({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    // the animation to be applied on the icon is given here
    Animation<double> animation = super.listenable;

    // the icon to be used is passed here
    return Icon(
      Icons.airplanemode_active,
      color: Colors.red,
      size: animation.value,
    );
  }
}

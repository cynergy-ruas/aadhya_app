import 'package:flutter/material.dart';

/// The prefix icon for text form fields
class TextFormFieldPrefix extends InputDecoration {
  TextFormFieldPrefix({
    @required String hintText,
    @required Widget icon,
    Color color = const Color(0xff2F3857),
    double topLeftRadius = 10,
    double bottomLeftRadius = 10,
  }) : super(
    hintText: hintText,
    prefixIcon: Container(
      decoration: BoxDecoration(
        color: Color(0xff2F3857),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          topLeft: Radius.circular(10),
        )
      ),
      child: icon,
    ),
    prefix: SizedBox(width: 10,)
  );
}
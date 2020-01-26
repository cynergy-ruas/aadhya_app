import 'package:flutter/material.dart';

/// The shadow for text form fields
class TextFormFieldShadow extends BoxDecoration {
  TextFormFieldShadow() : super(
    // to get a curved border
    borderRadius: BorderRadius.circular(10.0),
    // to give a shadow to the tf
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}
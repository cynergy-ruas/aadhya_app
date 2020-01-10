import 'package:flutter/material.dart';

ThemeData dwimayTheme = ThemeData(
  // The background color for major parts of the app (toolbars, tab bars, etc).
  primaryColor: Color(0xff222831),

  // A color that contrasts with the primaryColor, e.g. used as the remaining part of a progress bar.
  backgroundColor: Color(0xffeeeeee),

  // The default color of the Material that underlies the Scaffold.
  // The background color for a typical material app or a page within the app.
  scaffoldBackgroundColor: Color(0xffeeeeee),

  // The foreground color for widgets (knobs, text, overscroll edge effect, etc).
  accentColor: Color(0xff00adb5),

  // Text with a color that contrasts with the card and canvas colors.
  textTheme: TextTheme(
    // Used for the default text style for Material.
    body1: TextStyle(),

    // Used for emphasizing text that would otherwise be body1.
    body2: TextStyle(),

    // Used for text on RaisedButton and FlatButton.
    button: TextStyle(),

    // Used for auxiliary text associated with images.
    caption: TextStyle(),

    // Used for large text in dialogs (e.g., the month and year in the dialog shown by showDatePicker).
    headline: TextStyle(),

    // The smallest style. Typically used for captions or to introduce a (larger) headline.
    overline: TextStyle(),

    // Used for the primary text in lists (e.g., ListTile.title).
    subhead: TextStyle(),

    // For medium emphasis text that's a little smaller than subhead.
    subtitle: TextStyle(),

    // Used for the primary text in app bars and dialogs (e.g., AppBar.title and AlertDialog.title).
    title: TextStyle(),
  ),

  // The default InputDecoration values for InputDecorator, TextField, and
  // TextFormField are based on this theme
  inputDecorationTheme: InputDecorationTheme(
    // The padding for the input decoration's container.
    contentPadding: EdgeInsets.only(left: 12, right: 12),

    // The border to display when the InputDecorator is disabled and is not showing an error.
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.transparent, width: 1.0)),

    // The border to display when the InputDecorator is enabled and is not showing an error.
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.transparent, width: 1.0)),

    // style for hint text.
    hintStyle: TextStyle(
      color: Colors.white54,
      fontFamily: 'OpenSans',
    ),

    labelStyle: TextStyle(),

    // The color to fill the decoration's container with, if filled is true
    fillColor: Color(0xff4c4c4c),

    // If true the decoration's container is filled with fillColor
    filled: true,

    // The border to display when the InputDecorator has the focus and is not showing an error.
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.transparent, width: 1.0)),
  ),
);

import 'package:flutter/material.dart';

ThemeData dwimayTheme = ThemeData(
  // The background color for major parts of the app (toolbars, tab bars, etc).
  primaryColor: Color(0xff1089ff),

  // A color that contrasts with the primaryColor, e.g. used as the remaining part of a progress bar.
  backgroundColor: Color(0xff11161a),

  // The default color of the Material that underlies the Scaffold.
  // The background color for a typical material app or a page within the app.
  scaffoldBackgroundColor: Color(0xff11161a),

  // The foreground color for widgets (knobs, text, overscroll edge effect, etc).
  accentColor: Color(0xff50d890),

  // The color of Material when it is used as a Card.
  cardColor: Color(0xff27272f),

  // background color for dialogs
  dialogBackgroundColor: Color(0xff24213B),

  // Text with a color that contrasts with the card and canvas colors.
  textTheme: TextTheme(
    // Used for the default text style for Material.
    body1: TextStyle(
      fontFamily: "glacial-indifference",
      color: Color(0xffe5e5e5),
    ),

    // Used for emphasizing text that would otherwise be body1.
    body2: TextStyle(
      fontFamily: "glacial-indifference",
      color: Color(0xffe5e5e5),
    ),

    // Used for text on RaisedButton and FlatButton.
    button: TextStyle(
      fontFamily: "glacial-indifference",
      color: Color(0xffe5e5e5),
    ),

    // Used for auxiliary text associated with images.
    caption: TextStyle(
      fontFamily: "glacial-indifference",
      color: Color(0xffe5e5e5),
    ),

    // Used for large text in dialogs (e.g., the month and year in the dialog shown by showDatePicker).
    headline: TextStyle(
      fontFamily: "glacial-indifference",
      color: Color(0xffe5e5e5),
    ),

    // The smallest style. Typically used for captions or to introduce a (larger) headline.
    overline: TextStyle(
      fontFamily: "glacial-indifference",
      color: Color(0xffe5e5e5),
    ),

    // Used for the primary text in lists (e.g., ListTile.title).
    subhead: TextStyle(
      fontFamily: "glacial-indifference",
      color: Color(0xffe5e5e5),
    ),

    // For medium emphasis text that's a little smaller than subhead.
    subtitle: TextStyle(
      fontSize: 18,
      fontFamily: "glacial-indifference",
      fontWeight: FontWeight.bold,
      color: Color(0xffe5e5e5),
    ),

    // Used for the primary text in app bars and dialogs (e.g., AppBar.title and AlertDialog.title).
    title: TextStyle(
      fontFamily: "glacial-indifference",
      fontSize: 28,
      fontWeight: FontWeight.bold,
      height: 1,
      color: Color(0xffe5e5e5),
    ),
  ),

  // The default InputDecoration values for InputDecorator, TextField, and
  // TextFormField are based on this theme
  inputDecorationTheme: InputDecorationTheme(
    // The padding for the input decoration's container.
    contentPadding: EdgeInsets.only(left: 12, right: 12),

    // The border to draw around the field
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),

    // border when the field is focused and has error
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),

    // The border to display when the InputDecorator has the focus and is not showing an error.
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),

    // The border to display when the InputDecorator is disabled and is not showing an error.
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),

    // The border to display when the InputDecorator is enabled and is not showing an error.
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),

    // The border to display when an error occurs
    // The border to display when the InputDecorator is enabled and is not showing an error.
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),

    // style for hint text.
    hintStyle: TextStyle(
      color: Colors.grey,
      fontFamily: "glacial-indifference",
    ),

    labelStyle: TextStyle(
      color: Color(0xffe5e5e5),
      fontWeight: FontWeight.bold,
      fontFamily: "glacial-indifference",
    ),

    // The color to fill the decoration's container with, if filled is true
    fillColor: Color(0xff161824),

    // If true the decoration's container is filled with fillColor
    filled: true,
  ),

  iconTheme: IconThemeData(
    color: Color(0xffe5e5e5),
  )
);

class Style {
  static final baseTextStyle = const TextStyle();
  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 11.0,
  );
  static final commonTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 14.0,
      fontWeight: FontWeight.w400);
  static final titleTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400);
  static final buttonTextStyle = TextStyle(
    color: Colors.white,
    letterSpacing: 1.5,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );
}

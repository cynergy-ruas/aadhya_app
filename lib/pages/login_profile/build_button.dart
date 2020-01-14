import 'package:flutter/material.dart';

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
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}

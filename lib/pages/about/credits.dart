import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Tech partner
        Text(
          "Tech Partner",
          style: Theme.of(context).textTheme.title.copyWith(
            color: Theme.of(context).primaryColor
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/cynergyLogoWhite.png",
              width: 250,
            ),
          ],
        ),

        SizedBox(height: 40,),

        // the developers title
        Text(
          Strings.poweredByTitle,
          style: Theme.of(context).textTheme.title.copyWith(
            color: Theme.of(context).primaryColor
          ),
        ),

        // gap
        SizedBox(height: 10,),

        // the special thanks content
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              "assets/images/federateOne.png",
              height: 80,
            )
          ],
        ),
      ],
    );
  }
}
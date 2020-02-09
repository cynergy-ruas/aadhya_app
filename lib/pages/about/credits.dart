import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Credits title
        Text(
          Strings.creditsTitle,
          style: Theme.of(context).textTheme.title.copyWith(
            color: Theme.of(context).primaryColor
          ),
        ),

        // gap
        SizedBox(height: 20,),

        // Tech partner
        Text(
          "Tech Partner",
          style: Theme.of(context).textTheme.headline.copyWith(
            fontSize: 22
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/cynergyLogoWhite.png",
              width: MediaQuery.of(context).size.width * 0.7,
            ),
          ],
        ),

        SizedBox(height: 40,),


        // the developers title
        Text(
          Strings.developersTitle,
          style: Theme.of(context).textTheme.headline.copyWith(
            fontSize: 22
          ),
        ),

        // gap
        SizedBox(height: 10,),

        // the developers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Shyamant Achar",
              style: TextStyle(fontSize: 18,),
            ),

            Text(
              "Tanishq Porwar",
              style: TextStyle(fontSize: 18,),
            )
          ],
        ),

        // gap
        SizedBox(height: 40,),

        // the developers title
        Text(
          Strings.specialThanksTitle,
          style: Theme.of(context).textTheme.headline.copyWith(
            fontSize: 22
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
              height: 100,
            )
          ],
        ),
      ],
    );
  }
}
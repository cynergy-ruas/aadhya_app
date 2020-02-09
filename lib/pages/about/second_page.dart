import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // the about content title
        Text(
          Strings.aboutContentTitle,
          style: Theme.of(context).textTheme.title.copyWith(
            color: Theme.of(context).primaryColor
          ),
        ),

        // gap
        SizedBox(height: 20,),

        // the about content
        Text(
          Strings.aboutContent,
          style: Theme.of(context).textTheme.body1,
        ),

        // gap
        SizedBox(height: 40,),

        // The fest theme description title
        Text(
          Strings.festThemeDescriptionTitle,
          style: Theme.of(context).textTheme.title.copyWith(
            color: Theme.of(context).primaryColor
          ),
        ),

        // gap
        SizedBox(height: 20,),

        // the fest theme description
        Text(
          Strings.festThemeDescription,
          style: Theme.of(context).textTheme.body1
        ),

        // gap
        SizedBox(height: 40,),

        // Credits title
        Text(
          Strings.creditsTitle,
          style: Theme.of(context).textTheme.title.copyWith(
            color: Theme.of(context).primaryColor
          ),
        ),

        // gap
        SizedBox(height: 20,),

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
        Text(
          Strings.developers,
        ),

        // gap
        SizedBox(height: 20,),

        // the developers title
        Text(
          Strings.specialThanksTitle,
          style: Theme.of(context).textTheme.headline.copyWith(
            fontSize: 22
          ),
        ),

        // gap
        SizedBox(height: 10,),

        // the developers
        Text(
          Strings.specialThanks,
        ),

        // gap (required)
        SizedBox(height: 180,)
      ],
    );
  }
}
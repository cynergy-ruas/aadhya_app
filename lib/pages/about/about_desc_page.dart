import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';

/// The page that describes the fest
class AboutDescription extends StatelessWidget {

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
      ],
    );
  }
}
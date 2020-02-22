import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';

/// The page that describes the fest theme
class ThemeDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
        RichText(
          text: TextSpan(
            text: Strings.festThemeDescription,
            style: Theme.of(context).textTheme.body1
          ),
        ),

        // gap
        SizedBox(height: 40,),
      ],
    );
  }
}
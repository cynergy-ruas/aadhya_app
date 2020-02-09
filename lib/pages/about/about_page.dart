import 'package:dwimay/pages/about/credits.dart';
import 'package:dwimay/pages/about/first_page.dart';
import 'package:dwimay/pages/about/about_desc_page.dart';
import 'package:dwimay/pages/about/theme_desc_page.dart';
import 'package:dwimay/widgets/dot_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The about page. Contains the introduction to the fest.
class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  /// The controller for the page view
  PageController _controller;

  @override
  void initState() {
    super.initState();

    // initializing the controller
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 5.0),
            child: PageView(
              controller: _controller,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: <Widget>[
                FirstPage(),

                // the fest description
                Center(
                  child: AboutDescription(),
                ),

                // the theme description
                Center(
                  child: ThemeDescription(),
                ),

                // the credits page
                Center(
                  child: Credits(),
                )
              ],
            ),
          ),
        ),

        DotIndicatorWidget(
          controller: _controller,
          dotCount: 4,
        )
      ],
    );
  }
}

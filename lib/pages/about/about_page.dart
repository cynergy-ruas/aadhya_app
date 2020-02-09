import 'package:dwimay/pages/about/first_page.dart';
import 'package:dwimay/pages/about/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// The about page. Contains the introduction to the fest.
class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            FirstPage(),
            SecondPage()
          ],
        )
      ),
    );
  }
}

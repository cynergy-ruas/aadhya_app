import 'package:dwimay/pages/faq/faq_page.dart';
import 'package:dwimay/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          // adding the contents in a column so they appear one after
          // the other.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // used to add a gap between the contents.
              SizedBox(
                height: 20,
              ), 

              // the title and FAQ button
              Row(
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/svg/fest_logo.svg",
                    width: 150,
                  ),

                  // gap
                  Expanded(child: Container(),),

                  IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: Icon(FontAwesomeIcons.questionCircle),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FAQPage())
                    ),
                  )
                ],
              ),

              // gap
              SizedBox(
                height: 10,
              ),

              // the about content, fills the rest of the space.
              // hence, in a [Expanded]
              Expanded(
                // making the text scrollable
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    // the about content title
                    Text(
                      Strings.aboutContentTitle,
                      style: Theme.of(context).textTheme.title,
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
                      style: Theme.of(context).textTheme.title,
                    ),

                    // gap
                    SizedBox(height: 20,),

                    // the fest theme description
                    Text(
                      Strings.festThemeDescription,
                      style: Theme.of(context).textTheme.body1
                    ),

                    // gap (required)
                    SizedBox(height: 80,)
                  ],
                ),
              ),

              // gap
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

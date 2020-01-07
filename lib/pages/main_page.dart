import 'package:dwimay/pages/about_page.dart';
import 'package:dwimay/pages/profile_page.dart';
import 'package:dwimay/pages/registered_events.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/// The main page. It isn't technically a page, but it consists
/// of the bottom navigation bar that is used to navigate to 
/// other pages.
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // the pages that can be navigated to from the
    // bottom navigation bar. The order of the pages is 
    // important.
    _pages = [
      AboutPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {

    // the default controller for the tab bar
    return DefaultTabController(
      length: 2, // the length should be changed when new pages are added to the tab bar

      // the child
      child: Scaffold(

        // the tab bar
        appBar: PreferredSize(
          // setting the preferred size of the bar
          preferredSize: Size(MediaQuery.of(context).size.width, 100),

          // creating the tab bar on a card
          child: SafeArea(
            child: Card(
              
              // the elevation of the card
              elevation: 26.0,

              // the color
              color: Theme.of(context).primaryColor,

              // the tabs
              child: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.info),),
                  Tab(icon: Icon(Icons.person))
                ],

                // defining how the indicator should look like
                indicator: UnderlineTabIndicator(
                  insets: EdgeInsets.symmetric(horizontal: 10),
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 2
                  )
                )
              ),
            ),
          )
        ),

        // the body of the app is wrapped in a Bottom sheet widget 
        // called [SlidingUpPanel]. This widget displays the list
        // of registered events if the user has logged in.
        body: SlidingUpPanel(

          // the contents of the panel
          panel: RegisteredEvents(),

          // the body of the application
          body: TabBarView(

            // setting the physics to user
            physics: BouncingScrollPhysics(),

            // the pages
            children: _pages
          ),

          // setting the border of the sheet
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0)
          ),

          // setting the parallax effect
          parallaxEnabled: true,
        )

      ),
    );
  }
}
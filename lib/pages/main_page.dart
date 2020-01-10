import 'package:dwimay/pages/about_page.dart';
import 'package:dwimay/pages/announcements_page.dart';
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

  /// The list of pages
  List<Widget> _pages;

  /// the index of the current page
  int _currentPage;

  @override
  void initState() {
    super.initState();

    // the pages that can be navigated to from the
    // bottom navigation bar. The order of the pages is 
    // important.
    _pages = [
      AboutPage(),
      ProfilePage(),
      AnnouncementsPage()
    ];

    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {

    // the default controller for the tab bar
    return DefaultTabController(
      length: 2, // the length should be changed when new pages are added to the tab bar

      // the child
      child: Scaffold(

        // the tab bar
        appBar: AppBar(
          title: Text("Dwimay"),
        ),

        // the bottom nav bar
        bottomNavigationBar: Container( // adding a shadow around the nav bar
          height: 45,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 5,
                color: Colors.black12
              )
            ]
          ),

          // the actual nav bar
          child: BottomNavigationBar(
            // the index of the highlighted item
            currentIndex: _currentPage,

            // the icons in the nav bar
            items: <BottomNavigationBarItem> [

              // icon for the about page
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                title: Container(),
              ),

              // the icon for the profile page
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Container(),
              ),

              // the icon for the announcments page
              BottomNavigationBarItem(
                icon: Icon(Icons.speaker),
                title: Container()
              )
            ],

            // defining what to do when a tab in the nav bar is tapped
            onTap: (int index) {
              setState(() {
                // setting the [_currentPage] to the index of the tapped tab
                _currentPage = index;
              });
            },
          ),
        ),

        // the body of the app is wrapped in a Bottom sheet widget 
        // called [SlidingUpPanel]. This widget displays the list
        // of registered events if the user has logged in.
        body: SlidingUpPanel(

          // the contents of the panel
          panel: RegisteredEvents(),

          minHeight: 60,

          // the body of the application
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _pages[_currentPage],
          ),

          // setting the border of the sheet
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14.0),
            topRight: Radius.circular(14.0)
          ),

          // setting the parallax effect
          parallaxEnabled: true,
        )

      ),
    );
  }
}
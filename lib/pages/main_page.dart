import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dwimay/pages/about_page.dart';
import 'package:dwimay/pages/login_page.dart';
import 'package:dwimay/pages/events_page.dart';
import 'package:flutter/material.dart';

/// The main page. It isn't technically a page, but it consists
/// of the bottom navigation bar that is used to navigate to
/// other pages.
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _pages;
  int _currentPage;

  @override
  void initState() {
    super.initState();

    // the pages that can be navigated to from the
    // bottom navigation bar. The order of the pages is
    // important.
    _pages = [
      AboutPage(),
      LoginPage(),
      EventsPage(),
    ];

    _currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // the app bar
      appBar: AppBar(
        title: Text("Dwimay"),
      ),

      // the bottom navigation bar
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // background color of the bar
            canvasColor: Color(0xff393e46),

            // icon color of the selected tab
            primaryColor: Color(0xff00adb5),

            // icon color of the unselected tab
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Color(0xffeeeeee)))),
        child: CurvedNavigationBar(
          // height of the navigation bar
          height: 60,

          // the duration of the animation
          animationDuration: Duration(milliseconds: 300),

          // background color
          backgroundColor: Colors.transparent,

          // the items in the bottom navigation bar. The order of the
          // items should match the order of the pages in [_pages]
          items: <Widget>[
            // icon for about page
            Icon(Icons.info),

            // icon for profile page
            Icon(Icons.person),

            // icon for event page
            Icon(Icons.event_note),
          ],

          // callback to execute when a bottom navigation bar
          // item is tapped.
          onTap: (index) {
            // the [_currentPage] is set to the index of the
            // tapped item, in a [setState] call.
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
      // body, basically the page to show on screen
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 150),
        child: _pages[_currentPage],
      ),
    );
  }
}

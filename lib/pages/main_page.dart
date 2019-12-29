import 'package:dwimay/pages/profile_page.dart';
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
      ProfilePage(),
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
      bottomNavigationBar: BottomNavigationBar(
        // callback to execute when a bottom navigation bar
        // item is tapped.
        onTap: (index) {
          // the [_currentPage] is set to the index of the 
          // tapped item, in a [setState] call.
          setState(() {
            _currentPage = index;
          });
        },

        // the items in the bottom navigation bar. The order of the
        // items should match the order of the pages in [_pages]
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Container() // an empty container because the `title` argument should not be null.
          ),

          // dummy item since the number of items should be greater
          // than or equal to 2. otherwise the app will crash on 
          // startup. To be removed when more pages are added. 
          // If tapped, the app will crash since there is only 1 page
          // in the [_pages] list.
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            title: Text("Dummy. Tap to crash app")
          ),

        ],
      ),

      // body, basically the page to show on screen
      body: _pages[_currentPage],

    );
  }
}
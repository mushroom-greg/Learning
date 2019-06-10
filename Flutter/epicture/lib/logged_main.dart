import 'package:flutter/material.dart';
import 'package:epicture/profile.dart';
import 'package:epicture/search.dart';
import 'package:epicture/home.dart';

class LoggedMain extends StatefulWidget {
  static String tag = 'logged_main';

  LoggedMain({Key key}) : super(key: key);

  _LoggedMainState createState() => new _LoggedMainState();
}

class _LoggedMainState extends State<LoggedMain> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300), curve: Curves.ease
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PageView(
        children: [
          new Home(),
          new Search(),
          new Profile()
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Colors.blue,
        ), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          items: [
            new BottomNavigationBarItem(
              title: new Text(
                "Home",
                style: new TextStyle(color: Colors.white),
              ),
              icon: new Icon(
                Icons.home,
                color: Colors.white
              ),
            ),
            new BottomNavigationBarItem(
              title: new Text(
                "Search",
                style: new TextStyle(color: Colors.white),
              ),
              icon: new Icon(
                Icons.search,
                color: Colors.white
              ),
            ),
            new BottomNavigationBarItem(
              title: new Text(
                "Profile",
                style: new TextStyle(color: Colors.white),
              ),
              icon: new Icon(
                Icons.account_circle,
                color: Colors.white
              ),
            )
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}

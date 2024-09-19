import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluspay/Const/Constants.dart';
import 'package:pluspay/MainWidgets/Drawer.dart';
import 'package:pluspay/Screens/History.dart';
import 'package:pluspay/Screens/HomePage.dart' show HomePage;
import 'package:pluspay/Screens/Profile.dart';
import 'package:pluspay/Screens/Services.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HistoryPage(),
    ServicePage(),
    ProfilePage(),
  ];
  int _currentSelected = 0;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    index == 3
        ? _drawerKey.currentState?.openEndDrawer()
        : setState(() {
            _currentSelected = index;
          });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _drawerKey,
        body: _widgetOptions.elementAt(_currentSelected),
        endDrawer: DrawerWidget(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          currentIndex: _currentSelected,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedLabelStyle:
              TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          selectedItemColor: themeBlue,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'History',
              icon: Icon(Icons.history),
            ),
            BottomNavigationBarItem(
              label: 'Services',
              icon: Icon(Icons.apps_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(CupertinoIcons.person_alt_circle),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
        elevation: 10,
        title: Text('Confirm Exit!'),
        titleTextStyle: TextStyle(
            fontSize: 16,
            letterSpacing: 0.6,
            color: Color(0xff333333),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold),
        content: Text('Are you sure you want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
    // HapticFeedback.mediumImpact();

    // else {
    //   _showDialog();
    // }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
        elevation: 10,
        title: Text('Confirm Exit!'),
        titleTextStyle: TextStyle(
            fontSize: 16,
            letterSpacing: 0.6,
            color: Color(0xff333333),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold),
        content: Text('Are you sure you want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}

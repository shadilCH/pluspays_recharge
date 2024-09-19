import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pluspay/Const/sharedPref.dart';
import 'package:pluspay/MainWidgets/BottomNav.dart';
import 'package:pluspay/Screens/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var currentLoc = "";

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              // fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 1,
            ),
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ),
            left: 100,
            right: 100,
            bottom: MediaQuery.of(context).size.height * 0.14,
          )
        ],
      ),
    );
  }

  _loadWidget() async {
    var _duration = Duration(seconds: 4);

    var prefs = await getSharedPrefrence('userId');
    var token = await getSharedPrefrence('token');
    var name = await sharedPrefrence("dash", "0");
    print("strId");
    print(token);
    print(prefs);
    // if(strId != null){
    return Timer(
        Duration(seconds: 4), prefs == null ? navigationLogin : navigationHome);
    // }
    // else{
    //   return Timer(Duration(seconds: 4), navigationLogin);
    // }
    return Timer(_duration, navigationLogin);
  }

  void navigationLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }

  void navigationHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNav()),
    );
  }
}

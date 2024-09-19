import 'package:flutter/material.dart';

import 'Screens/Splash.dart';
var width;
var height;
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _darkTheme = ThemeData(
    hintColor: Colors.red,
    brightness: Brightness.dark,
    primaryColor: Colors.amber,
    fontFamily: 'Poppins',
  );

  ThemeData _lightTheme = ThemeData(
      hintColor: Colors.pink,
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      primaryColor: Colors.blue);
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlusPays',
      theme: ThemeData(fontFamily: 'Poppins'),
      // theme: _light ? _lightTheme : _darkTheme,

      home: SplashScreen(),
      // home: Login(),
    );
  }
}

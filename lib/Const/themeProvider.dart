import 'package:flutter/material.dart';
import 'package:pluspay/Const/storeManager.dart';


class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    hintColor: Colors.white,
    // accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(background: const Color(0xFF212121)),
  );

  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    hintColor: Colors.black,
    // actionIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey).copyWith(background: const Color(0xFFE5E5E5)),
  );

  ThemeData? _themeData;
  ThemeData? getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
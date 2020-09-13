import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.grey,
  primaryColor: Color(0xff01A0C7), //Colors.white,
  brightness: Brightness.light,
  backgroundColor: Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Color(0xff01A0C7)),
// dividerColor: Colors.white54,
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Color(0xff01A0C7)),
  appBarTheme: AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(color: Color(0xff01A0C7)),
      textTheme: TextTheme(headline1: TextStyle(color: Color(0xff01A0C7)))),
);

ThemeData dark = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: Color(0xFF000000),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    // dividerColor: Colors.black54,
    scaffoldBackgroundColor: Colors.black,
    textSelectionColor: Colors.white,
    // iconTheme:  IconThemeData(color: Color(0xff01A0C7)),
    appBarTheme: AppBarTheme(
        // color: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff01A0C7))));

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefs;
  bool _lightTheme;

  bool get lightTheme => _lightTheme;

  ThemeNotifier() {
    _lightTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _lightTheme = !_lightTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _lightTheme = _prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _lightTheme);
  }
}

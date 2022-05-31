import 'package:flutter/material.dart';

class AppTheming {
  static const primarySwatch = Colors.indigo;
  static var primaryColor = Colors.indigo[600];
  static var accentColor = Colors.indigo[200];
  static const backgroundColor = Colors.white;
  static const errorColor = Colors.redAccent;
  static var bottomAppBarColor = Colors.indigo[600];

  static var appBarTheme = AppBarTheme(
    color: Colors.white,
    elevation: 1,
    foregroundColor: Colors.indigo[900],
  );

  static var headline4 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.indigo[600],
  );

  static const headline6 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const headline1 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );

  static var headline2 = TextStyle(
    color: Colors.indigo[200],
  );

  static const fontFamily = 'Nunito';
  static const title = 'Albums App';

  static const altScreenPrimaryColor = Colors.black;
  static const altScreenAccentColor = Colors.white;
}

import 'package:flutter/material.dart';

class AppTheming {
  static const Color _indigo900 = Color(0xFF1A237E);
  static const Color _indigo200 = Color(0xFF9FA8DA);
  static const Color _indigo600 = Color(0xFF3949AB);
  static const Color _grey600 = Color(0XFFF757575);

  static const primarySwatch = Colors.indigo;
  static const primaryColor = _indigo600;
  static const accentColor = _indigo200;
  static const backgroundColor = Colors.white;
  static const errorColor = Colors.redAccent;
  static const bottomAppBarColor = _indigo600;

  static const appBarTheme = AppBarTheme(
    color: Colors.white,
    elevation: 1,
    foregroundColor: _indigo900,
  );

  static const headline4 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: _indigo600,
  );

  static const headline6 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const headline1 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );

  static const headline2 = TextStyle(
    color: _indigo200,
  );

  static const headline3 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const headline5 = TextStyle(
    fontSize: 18,
    color: _indigo900,
    fontWeight: FontWeight.bold,
  );

  static const bodytext1 = TextStyle(
    color: _grey600,
    fontSize: 15,
  );

  static const fontFamily = 'Nunito';
  static const title = 'Albums App';

  static const altScreenPrimaryColor = Colors.black;
  static const altScreenAccentColor = Colors.white;

  static const Color selectedNavigationLabelColor = Color(0xFFBDBDBD);
  static const Color unselectedNavigationLabelColor = Colors.white;

  static ThemeData appThemeData = ThemeData(
    textTheme: ThemeData().textTheme.copyWith(
          headline4: AppTheming.headline4,
          headline6: AppTheming.headline6,
          headline1: AppTheming.headline1,
          headline2: AppTheming.headline2,
          headline3: AppTheming.headline3,
          headline5: AppTheming.headline5,
          bodyText1: AppTheming.bodytext1,
        ),
    fontFamily: AppTheming.fontFamily,
    primarySwatch: AppTheming.primarySwatch,
    accentColor: AppTheming.accentColor,
    primaryColor: AppTheming.primaryColor,
    backgroundColor: AppTheming.backgroundColor,
    errorColor: AppTheming.errorColor,
    bottomAppBarColor: AppTheming.bottomAppBarColor,
    appBarTheme: AppTheming.appBarTheme,
  );
}

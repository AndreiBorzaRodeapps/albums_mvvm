import 'dart:io';

import 'package:flutter/material.dart';

class AppTheming {
  static const Color _indigo900 = Color(0xFF1A237E);
  static const Color _indigo200 = Color(0xFF9FA8DA);
  static const Color _indigo600 = Color(0xFF3949AB);
  static const Color _indigo100 = Color(0xFFE8EAF6);
  static const Color _grey600 = Color(0xFFF757575);
  static const Color _formColor = Color(0xFF3F5AA6);

  static const primarySwatch = Colors.indigo;
  static const primaryColor = _indigo600;
  static const accentColor = _indigo200;
  static const backgroundColor = Colors.white;
  static const errorColor = Colors.redAccent;
  static const bottomAppBarColor = _indigo600;
  static const secondaryBackgroundColor = _indigo100;

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

  static const userProfileHeadline = TextStyle(
    color: _indigo900,
    fontSize: 25,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  static const applyButtonTheme = TextStyle(
    color: _indigo600,
    fontSize: 13,
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
  );

  static const formDecorationStyle = TextStyle(
    color: _indigo600,
    fontWeight: FontWeight.bold,
    fontSize: 13,
    fontFamily: fontFamily,
  );

  static const formErrorStyle = TextStyle(
    color: errorColor,
    fontWeight: FontWeight.bold,
    fontSize: 13,
    fontFamily: fontFamily,
  );

  static const formTextStyle = TextStyle(
    color: _formColor,
    fontSize: 15,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
  );

  static const formErrorTextStyle = TextStyle(
    color: errorColor,
    fontSize: 15,
    fontFamily: fontFamily,
  );

  static const fontFamily = 'Nunito';
  static const title = 'Albums App';

  static const altScreenPrimaryColor = Colors.black;
  static const altScreenAccentColor = Colors.white;

  static const Color selectedNavigationLabelColor = Color(0xFFBDBDBD);
  static const Color unselectedNavigationLabelColor = Colors.white;

  static const defaultSnackBarBackground = Colors.black87;

  static const buttonTextTheme = TextStyle(
    color: backgroundColor,
    fontSize: 13,
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
  );

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
    buttonColor: primaryColor,
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

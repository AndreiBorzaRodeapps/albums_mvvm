import 'package:flutter/material.dart';
import './screens/splash_screen.dart';
import 'screens/album_list/albums_list_screen.dart';
import './screens/friends_screen.dart';
import './screens/news_screen.dart';
import './screens/no_internet_screen.dart';
import './screens/profile_screen.dart';
import './screens/main_screen.dart';

import './theming/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTheming.title,
      theme: ThemeData(
        textTheme: ThemeData().textTheme.copyWith(
              headline4: AppTheming.headline4,
              headline6: AppTheming.headline6,
              headline1: AppTheming.headline1,
              headline2: AppTheming.headline2,
            ),
        fontFamily: AppTheming.fontFamily,
        primarySwatch: AppTheming.primarySwatch,
        accentColor: AppTheming.accentColor,
        primaryColor: AppTheming.primaryColor,
        backgroundColor: AppTheming.backgroundColor,
        errorColor: AppTheming.errorColor,
        bottomAppBarColor: AppTheming.bottomAppBarColor,
        appBarTheme: AppTheming.appBarTheme,
      ),
      home: MySplashScreen(),
      routes: {
        MainScreen.routeName: (_) => MainScreen(),
        MySplashScreen.routeName: (_) => MySplashScreen(),
        AlbumsListScreen.routeName: (_) => AlbumsListScreen(),
        FriendsScreen.routeName: (_) => FriendsScreen(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
        NoInternetScreen.routeName: (_) => NoInternetScreen(),
        NewsScreen.routeName: (_) => NewsScreen(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/album_list/albums_list_screen.dart';
import 'screens/friends/friends_screen.dart';
import 'screens/news/news_screen.dart';
import 'screens/no_internet/no_internet_screen.dart';
import 'screens/profile/profile_screen.dart';
import './screens/main_screen.dart';

import './theming/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppTheming.title,
      theme: ThemeData(
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

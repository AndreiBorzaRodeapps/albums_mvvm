import 'package:flutter/material.dart';
import './screens/splash/splash_screen.dart';
import './screens/album_list/albums_list_screen.dart';
import './screens/friends/friends_screen.dart';
import './screens/news/news_screen.dart';
import './screens/no_internet/no_internet_screen.dart';
import './screens/profile/profile_screen.dart';
import './screens/main_screen.dart';
import './theming/app_theme.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ro', ''),
      ],
      debugShowCheckedModeBanner: false,
      title: AppTheming.title,
      theme: AppTheming.appThemeData,
      home: MySplashScreen(),
      routes: {
        MainScreen.routeName: (_) => MainScreen(),
        MySplashScreen.routeName: (_) => MySplashScreen(),
        AlbumsListScreen.routeName: (_) => AlbumsListScreen(),
        FriendsScreen.routeName: (_) => FriendsScreen(),
        NoInternetScreen.routeName: (_) => NoInternetScreen(),
        NewsScreen.routeName: (_) => NewsScreen(),
      },
    );
  }
}

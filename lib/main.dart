import 'package:albums_mvvm/screens/main_screen.dart';
import 'package:flutter/material.dart';
import './screens/splash_screen.dart';
import './screens/AlbumsListScreen.dart';
import './screens/FriendsScreen.dart';
import './screens/NewsScreen.dart';
import './screens/NoInternetScreen.dart';
import './screens/ProfileScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: ThemeData().textTheme.copyWith(
              headline4: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.indigo[600],
              ),
              headline6: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              headline1: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
        fontFamily: 'Nunito',
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigo[200],
        primaryColor: Colors.indigo[600],
        backgroundColor: Colors.white,
        errorColor: Colors.redAccent,
        bottomAppBarColor: Colors.indigo[600],
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 1,
          foregroundColor: Colors.indigo[900],
        ),
      ),
      home: MySplashScreen(),
      routes: {
        MainScreen.routeName: (_) => MainScreen(),
        MySplashScreen.routeName: (_) => MySplashScreen(),
        AlbumsListScreen.routeName: (_) => AlbumsListScreen(),
        FriendsScreen.routeName: (_) => FriendsScreen(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
        NoInternetScreen.routeName: (_) => NoInternetScreen(),
      },
    );
  }
}

import 'package:albums_mvvm/screens/AlbumsListScreen.dart';
import 'package:albums_mvvm/screens/NoInternetScreen.dart';
import 'package:flutter/material.dart';
import '../screens/FriendsScreen.dart';
import '../screens/NewsScreen.dart';
import '../screens/ProfileScreen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool hasInternet = false;

  void checkInternet() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(() => this.hasInternet = hasInternet);
    });
  }

  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return hasInternet
        ? DefaultTabController(
            initialIndex: 0,
            animationDuration: Duration(milliseconds: 100),
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('My Albums'),
              ),
              body: TabBarView(
                children: <Widget>[
                  AlbumsListScreen(),
                  FriendsScreen(),
                  NewsScreen(),
                  ProfileScreen(),
                ],
              ),
              bottomNavigationBar: Container(
                height: 55,
                color: Theme.of(context).primaryColor,
                child: TabBar(
                  padding: const EdgeInsets.only(top: 3),
                  labelColor: Colors.grey[400],
                  unselectedLabelColor: Theme.of(context).backgroundColor,
                  unselectedLabelStyle: Theme.of(context).textTheme.headline1,
                  labelStyle: TextStyle(
                    fontSize: 14,
                  ),
                  indicatorColor: Theme.of(context).primaryColor,
                  onTap: (value) {},
                  tabs: [
                    Tab(
                      icon: Icon(Icons.search),
                      text: 'BROWSE',
                    ),
                    Tab(
                      icon: Icon(Icons.emoji_emotions_outlined),
                      text: 'FRIENDS',
                    ),
                    Tab(
                      icon: Icon(Icons.file_copy_outlined),
                      text: 'NEWS',
                    ),
                    Tab(
                      icon: Icon(Icons.account_circle_outlined),
                      text: 'PROFILE',
                    ),
                  ],
                ),
              ),
            ),
          )
        : NoInternetScreen();
  }
}

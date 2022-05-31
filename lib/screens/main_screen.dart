import 'package:albums_mvvm/screens/album_details/album_details_screen.dart';
import 'package:albums_mvvm/screens/album_list/albums_list_screen.dart';
import 'package:albums_mvvm/screens/no_internet_screen.dart';
import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../screens/friends_screen.dart';
import '../screens/news_screen.dart';
import '../screens/profile_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool hasInternet = false;
  AlbumModel? _currentAlbum;

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

  void _changeAlbum(AlbumModel? album) {
    setState(
      () {
        _currentAlbum = album;
      },
    );
  }

  // void _selectPageIndex(int index) {
  //   setState(
  //     () {
  //
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return hasInternet
        ? DefaultTabController(
            initialIndex: 0,
            animationDuration: const Duration(milliseconds: 100),
            length: 4,
            child: Scaffold(
              appBar: _currentAlbum != null
                  ? null
                  : AppBar(
                      title: const Text('My Albums'),
                    ),
              body: TabBarView(
                children: <Widget>[
                  _currentAlbum == null
                      ? AlbumsListScreen(func: _changeAlbum)
                      : AlbumDetailsScreen(
                          changeCurrentAlbum: _changeAlbum,
                          album: _currentAlbum),
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
                  labelStyle: const TextStyle(
                    fontSize: 14,
                  ),
                  indicatorColor: Theme.of(context).primaryColor,
                  onTap: (value) {},
                  tabs: const [
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

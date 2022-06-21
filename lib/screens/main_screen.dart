import 'package:albums_mvvm/screens/album_details/album_details_screen.dart';
import 'package:albums_mvvm/screens/album_list/albums_list_screen.dart';
import 'package:albums_mvvm/screens/no_internet/no_internet_screen.dart';
import 'package:albums_mvvm/theming/app_dimensions.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../widgets/app_nav_bar.dart';
import 'friends/friends_screen.dart';
import 'news/news_screen.dart';
import 'profile/profile_screen/profile_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool hasInternet = false;
  late AlbumModel? _currentAlbum;
  int currentSelectedTab = 0;

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
    _changeAlbum(null);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkInternet();
    _changeAlbum(null);
  }

  void _changeAlbum(AlbumModel? album) {
    setState(
      () {
        _currentAlbum = album;
      },
    );
  }

  void changeCurrentScreen(int newVal) {
    setState(() {
      currentSelectedTab = newVal;
    });
  }

  Widget sendScreen(int index) {
    Widget retScreen = AlbumsListScreen();
    switch (index) {
      case 0:
        retScreen = _currentAlbum == null
            ? AlbumsListScreen(
                func: _changeAlbum,
                isOffline: !hasInternet,
              )
            : AlbumDetailsScreen(
                changeCurrentAlbum: _changeAlbum,
                album: _currentAlbum!,
              );
        return retScreen;
      case 1:
        retScreen = FriendsScreen();
        return retScreen;

      case 2:
        retScreen = NewsScreen();
        return retScreen;

      case 3:
        retScreen = ProfileScreen();
        return retScreen;

      default:
        return retScreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      maintainBottomViewPadding: true,
      child: Scaffold(
        appBar: _currentAlbum != null || currentSelectedTab == 3
            ? null
            : AppBar(
                title: Text(AppLocalizations.of(context)!.myAlbums),
                actions: hasInternet
                    ? null
                    : [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.error_outline,
                                color: AppTheming.errorColor,
                              ),
                            ],
                          ),
                        ),
                      ],
              ),
        body: sendScreen(currentSelectedTab),
        bottomNavigationBar:
            BottomNavBar(changeTabFn: changeCurrentScreen, totalTabs: 4),
      ),
    );
  }
}

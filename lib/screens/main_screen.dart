import 'package:albums_mvvm/screens/album_details/album_details_screen.dart';
import 'package:albums_mvvm/screens/album_list/albums_list_screen.dart';
import 'package:albums_mvvm/screens/no_internet/no_internet_screen.dart';
import 'package:albums_mvvm/theming/app_dimensions.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:flutter/material.dart';
import '../models/album_model.dart';
import 'friends/friends_screen.dart';
import 'news/news_screen.dart';
import 'profile/profile_screen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool hasInternet = false;
  late AlbumModel? _currentAlbum;

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

  List<Tab> get _tabsList {
    return [
      Tab(
        icon: const Icon(Icons.search),
        text: AppLocalizations.of(context)!.browse,
      ),
      Tab(
        icon: const Icon(Icons.emoji_emotions_outlined),
        text: AppLocalizations.of(context)!.friends,
      ),
      Tab(
        icon: const Icon(Icons.file_copy_outlined),
        text: AppLocalizations.of(context)!.news,
      ),
      Tab(
        icon: const Icon(Icons.account_circle_outlined),
        text: AppLocalizations.of(context)!.profile,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 100),
      length: _tabsList.length,
      child: Scaffold(
        appBar: _currentAlbum != null
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
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: AppTheming.errorColor,
                              ),
                            ],
                          ),
                        ),
                      ],
              ),
        body: TabBarView(
          children: <Widget>[
            _currentAlbum == null
                ? AlbumsListScreen(
                    func: _changeAlbum,
                    isOffline: !hasInternet,
                  )
                : AlbumDetailsScreen(
                    changeCurrentAlbum: _changeAlbum,
                    album: _currentAlbum!,
                  ),
            FriendsScreen(),
            NewsScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          height: AppDimensions.defaultNavigationBarHeight,
          color: Theme.of(context).primaryColor,
          child: TabBar(
            padding: const EdgeInsets.only(top: AppDimensions.xxsPadding),
            labelColor: AppTheming.selectedNavigationLabelColor,
            unselectedLabelColor: Theme.of(context).backgroundColor,
            unselectedLabelStyle: Theme.of(context).textTheme.headline1,
            labelStyle: const TextStyle(
              fontSize: AppDimensions.selectedLabelFontSize,
            ),
            indicatorColor: Theme.of(context).primaryColor,
            onTap: (value) {},
            tabs: _tabsList,
          ),
        ),
      ),
    );
  }
}

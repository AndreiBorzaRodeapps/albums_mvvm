import 'package:albums_mvvm/theming/app_dimensions.dart';
import 'package:flutter/material.dart';

import '../../models/album_model.dart';
import '../../theming/app_theme.dart';
import 'album_list_viewmodel.dart';
import '../../widgets/album_tile.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlbumsListScreen extends StatelessWidget {
  static const routeName = '/albums_list';
  final Function(AlbumModel)? func;
  final _albumViewModel = AlbumListViewModel();
  final bool isOffline;

  AlbumsListScreen({this.func, this.isOffline = false});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _albumViewModel.fetchAlbums(),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).bottomAppBarColor),
            )
          : Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  if (isOffline)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.smallPadding),
                      child: Text(
                        AppLocalizations.of(context)!.fetchedOfflineAlbums,
                        style: const TextStyle(color: AppTheming.errorColor),
                      ),
                    ),
                  Flexible(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (item, idx) {
                          return AlbumTile(
                            onTileTap: () {
                              if (_albumViewModel
                                      .showDetails(snapshot.data[idx]) &&
                                  func != null &&
                                  !isOffline) {
                                func!(snapshot.data[idx]);
                              } else {
                                if (!isOffline) {
                                  Fluttertoast.showToast(
                                    msg: 'Album unavailable!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor:
                                        Theme.of(context).errorColor,
                                    textColor:
                                        Theme.of(context).backgroundColor,
                                    fontSize: 15,
                                    timeInSecForIosWeb: 2,
                                  );
                                } else if (isOffline) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context)!
                                          .noInternetConnection,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: AppTheming.errorColor),
                                    ),
                                    duration: const Duration(
                                        seconds: AppDimensions
                                            .defaultSecondsWaitTime),
                                    backgroundColor:
                                        AppTheming.defaultSnackBarBackground,
                                  ));
                                }
                              }
                            },
                            icon: Icons.list_alt_sharp,
                            title: snapshot.data[idx].title,
                            subTitle: AppLocalizations.of(context)!
                                .albumWithId(snapshot.data[idx].id),
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// import '../DUMMY_DATA.dart';
import '../../models/album_model.dart';
import 'album_list_viewmodel.dart';
import '../no_internet/no_internet_screen.dart';
import '../../widgets/album_tile.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlbumsListScreen extends StatelessWidget {
  static const routeName = '/albums_list';
  final Function(AlbumModel)? func;
  final _albumViewModel = AlbumListViewModel();

  AlbumsListScreen({this.func});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _albumViewModel.fetchAlbums(),
      builder: (ctx, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).bottomAppBarColor),
                )
              : Container(
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (item, idx) {
                        return AlbumTile(
                          onTileTap: () {
                            if (_albumViewModel.showDetails(snapshot.data[idx]) &&
                                func != null) {
                              func!(snapshot.data[idx]);
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Album unavailable!',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Theme.of(context).errorColor,
                                textColor: Theme.of(context).backgroundColor,
                                fontSize: 15,
                                timeInSecForIosWeb: 2,
                              );
                            }
                          },
                          icon: Icons.list_alt_sharp,
                          currentAlbum: snapshot.data[idx],
                        );
                      }),
                ),
    );
  }
}

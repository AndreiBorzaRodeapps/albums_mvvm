import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// import '../DUMMY_DATA.dart';
import '../../models/album_model.dart';
import 'album_list_viewmodel.dart';
import '../no_internet_screen.dart';
import '../../widgets/album_tile.dart';

class AlbumsListScreen extends StatelessWidget {
  static const routeName = '/albums_list';
  final Function(AlbumModel)? func;
  final viewModel = AlbumListViewModel();

  AlbumsListScreen({this.func});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: viewModel.fetchAlbums(),
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
                            if (func != null) func!(snapshot.data[idx]);
                          },
                          icon: Icons.list_alt_sharp,
                          currentAlbum: snapshot.data[idx],
                        );
                      }),
                ),
    );
  }
}

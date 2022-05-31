import 'package:flutter/material.dart';
import '../../models/album_model.dart';

class AlbumDetailsScreen extends StatelessWidget {
  final AlbumModel? album;
  final Function? changeCurrentAlbum;

  AlbumDetailsScreen({this.changeCurrentAlbum, this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Details'),
        leading: InkWell(
          onTap: () {
            print('Called tap back');
            if (changeCurrentAlbum != null) changeCurrentAlbum!(null);
          },
          child: Center(
            child: Text(
              'Back',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
        ),
      ),
      body: Center(
        child: Text('Details for album id: ${album?.id}'),
      ),
      // bottomNavigationBar: _buildNavBar(context),
    );
  }
}

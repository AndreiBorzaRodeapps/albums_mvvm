import 'package:albums_mvvm/widgets/album_details_photos.dart';
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 40,
              child: Text(
                '${album!.title![0].toUpperCase()}',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      overflow: TextOverflow.ellipsis,
                      '${album!.title}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Album with id: ${album?.id}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Expanded(child: AlbumDetailPhotos()),
          ],
        ),
      ),
      // bottomNavigationBar: _buildNavBar(context),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../screens/album_details/album_details_screen.dart';

class AlbumTile extends StatelessWidget {
  // const AlbumTile({
  //   Key? key,
  // }) : super(key: key);
  final AlbumModel? currentAlbum;
  final IconData? icon;
  final VoidCallback? onTileTap;

  AlbumTile({this.currentAlbum, this.icon, this.onTileTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.black12,
            ),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                    Icon(
                      icon,
                      size: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListTile(
                  subtitle: Text('Album with id: ${currentAlbum?.id}'),
                  onTap: null,
                  // in caz ca se poate merge la details doar de pe sageata
                  title: Text(
                    overflow: TextOverflow.ellipsis,
                    currentAlbum?.title as String,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              IconButton(
                onPressed: onTileTap,
                icon: Icon(
                  Icons.chevron_right,
                  size: 25,
                ),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

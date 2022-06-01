import 'package:albums_mvvm/widgets/photo_tile.dart';
import 'package:flutter/material.dart';

import '../models/album_model.dart';

class AlbumDetailPhotos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextButton(
                  icon: Icons.favorite_border_outlined,
                  text: 'Save to favorites',
                ),
                VerticalDivider(
                  thickness: 1,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '1,324',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Photos',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  thickness: 1,
                ),
                IconTextButton(
                  icon: Icons.comment,
                  text: 'Add a comment',
                ),
              ],
            ),
          ),
          //////
          Divider(thickness: 1),
          SizedBox(height: 25),
          Text(
            'Photos',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (ctx, idx) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: PhotoTile(),
                      ),
                      Divider(thickness: 1),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class IconTextButton extends StatelessWidget {
  final IconData? icon;
  final String? text;

  IconTextButton({this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(icon),
          color: Theme.of(context).primaryColor,
        ),
        Text(
          text!,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

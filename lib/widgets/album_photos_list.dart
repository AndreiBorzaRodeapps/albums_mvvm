import 'package:flutter/material.dart';
import '../models/photo_model.dart';
import '../theming/app_dimensions.dart';
import '../widgets/photo_tile.dart';
import '../widgets/universal_app_divider.dart';

class AlbumPhotosList extends StatelessWidget {
  final List<PhotoModel> photos;

  AlbumPhotosList({required this.photos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: photos.length,
        itemBuilder: (ctx, idx) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.smallPadding),
                child: PhotoTile(photos[idx]),
              ),
              UniversalAppDivider(),
            ],
          );
        });
  }
}

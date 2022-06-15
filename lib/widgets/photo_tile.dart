import 'package:flutter/material.dart';
import '../models/photo_model.dart';
import '../theming/app_images.dart';
import '../theming/app_dimensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhotoTile extends StatelessWidget {
  final PhotoModel _photo;

  PhotoTile(this._photo);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.defaultImageHeight,
      child: Row(
        children: <Widget>[
          Container(
            height: AppDimensions.defaultImageHeight,
            width: AppDimensions.defaultImageWidth,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(AppDimensions.defaultBorderRadius),
              border: Border.all(color: Colors.black38),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(AppDimensions.defaultBorderRadius),
              child: Image.network(
                _photo.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.defaultPadding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: AppDimensions.smallPadding),
                  child: Text(
                    _photo.title,
                    style: Theme.of(context).textTheme.headline4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${AppLocalizations.of(context)!.photoWithId} ${_photo.id}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

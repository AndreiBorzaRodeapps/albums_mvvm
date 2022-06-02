import 'package:albums_mvvm/widgets/universal_app_divider.dart';
import 'package:albums_mvvm/widgets/icon_text_button.dart';
import 'package:albums_mvvm/widgets/photo_tile.dart';
import 'package:flutter/material.dart';

import '../models/album_model.dart';
import '../theming/app_dimensions.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlbumDetailsHorizontalBar extends StatelessWidget {
  final int totalPhotos;

  AlbumDetailsHorizontalBar({required this.totalPhotos});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UniversalAppDivider(),
          Container(
            height: AppDimensions.defaultImageHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextButton(
                  icon: Icons.favorite_border_outlined,
                  text: AppLocalizations.of(context)!.saveToFavorites,
                ),
                UniversalAppDivider(vertical: true),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.xsPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        totalPhotos.toString(),
                        style: TextStyle(
                          fontSize: AppDimensions.defaultFontSize,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      SizedBox(height: AppDimensions.xsPadding),
                      Text(
                        AppLocalizations.of(context)!.photos,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                UniversalAppDivider(vertical: true),
                IconTextButton(
                  icon: Icons.comment,
                  text: AppLocalizations.of(context)!.addAComment,
                ),
              ],
            ),
          ),
          //////
          UniversalAppDivider(),
          SizedBox(height: AppDimensions.defaultPadding),
          Text(
            AppLocalizations.of(context)!.photos,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

import 'package:albums_mvvm/theming/app_dimensions.dart';
import 'package:flutter/material.dart';
import '../models/album_model.dart';
import '../screens/album_details/album_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlbumTile extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTileTap;
  final String title;
  final String subTitle;

  AlbumTile({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('tile-$subTitle'),
      margin: const EdgeInsets.symmetric(vertical: AppDimensions.xxsPadding),
      height: AppDimensions.defaultTileHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.smallPadding,
            horizontal: AppDimensions.defaultPadding),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(AppDimensions.defaultBorderRadius),
            border: Border.all(
              color: Colors.black12,
            ),
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.smallPadding),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                    Icon(
                      icon,
                      size: AppDimensions.defaultIconSize,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListTile(
                  subtitle: Text(
                    subTitle,
                  ),
                  onTap: null,
                  // in caz ca se poate merge la details doar de pe sageata
                  title: Text(
                    overflow: TextOverflow.ellipsis,
                    title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              IconButton(
                key: Key('details-$subTitle'),
                onPressed: onTileTap,
                icon: Icon(
                  Icons.chevron_right,
                  size: AppDimensions.defaultIconSize,
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

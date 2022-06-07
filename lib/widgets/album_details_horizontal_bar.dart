import 'package:albums_mvvm/widgets/universal_app_divider.dart';
import 'package:albums_mvvm/widgets/icon_text_button.dart';
import 'package:albums_mvvm/widgets/photo_tile.dart';
import 'package:flutter/material.dart';

import '../models/album_model.dart';
import '../theming/app_dimensions.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlbumDetailsHorizontalBar extends StatelessWidget {
  final int photosTotalNumber;

  AlbumDetailsHorizontalBar({required this.photosTotalNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UniversalAppDivider(),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: IconTextButton(
                    onTap: () {},
                    icon: Icons.favorite_border_outlined,
                    text: AppLocalizations.of(context)!.saveToFavorites,
                  ),
                ),
                UniversalAppDivider(vertical: true),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.xsPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          photosTotalNumber.toString(),
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
                ),
                UniversalAppDivider(vertical: true),
                Expanded(
                  child: IconTextButton(
                    onTap: () {},
                    icon: Icons.comment,
                    text: AppLocalizations.of(context)!.addAComment,
                  ),
                ),
              ],
            ),
          ),
          //////
          UniversalAppDivider(),
          SizedBox(height: AppDimensions.defaultPadding),
          Text(
            AppLocalizations.of(context)!.photos,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: AppDimensions.smallFontSize),
          ),
        ],
      ),
    );
  }
}

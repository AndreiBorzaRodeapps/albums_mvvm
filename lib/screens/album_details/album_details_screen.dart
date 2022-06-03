import 'package:albums_mvvm/widgets/album_photos_list.dart';

import 'package:albums_mvvm/widgets/album_details_horizontal_bar.dart';
import 'package:flutter/material.dart';
import '../../models/album_model.dart';
import '../../theming/app_dimensions.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import './photo_list_viewmodel.dart';

class AlbumDetailsScreen extends StatelessWidget {
  final AlbumModel album;
  final Function changeCurrentAlbum;
  final _photoViewModel = PhotoListViewModel();

  AlbumDetailsScreen({required this.changeCurrentAlbum, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.details),
        leading: InkWell(
          onTap: () {
            changeCurrentAlbum(null);
          },
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.back,
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.only(
            top: AppDimensions.defaultPadding,
            left: AppDimensions.defaultPadding,
            right: AppDimensions.defaultPadding),
        child: FutureBuilder<dynamic>(
          future: _photoViewModel.fetchPhotosForAlbumId(album.id),
          builder: (ctx, snapshot) {
            print('Connection state: ${snapshot.connectionState}');
            print('Snapshot data: ${snapshot.data}');
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: AppDimensions.avatarRadius,
                        child: Text(
                          album.getFirstCharacter(upperCase: true),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.defaultPadding),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text(
                                overflow: TextOverflow.ellipsis,
                                album.title,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(
                                height: AppDimensions.xsPadding,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .albumWithId(album.id),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      AlbumDetailsHorizontalBar(
                          photosTotalNumber: snapshot.data.length),
                      AlbumPhotosList(photos: snapshot.data),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

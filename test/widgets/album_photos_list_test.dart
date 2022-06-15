import 'package:albums_mvvm/models/photo_model.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:albums_mvvm/widgets/album_photos_list.dart';
import 'package:albums_mvvm/widgets/photo_tile.dart';
import 'package:albums_mvvm/widgets/universal_app_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Album photos list test, should display a list of photo tiles',
      (widgetTester) async {
    final List<PhotoModel> mockPhotosList = [
      PhotoModel(albumId: 1, id: 1, title: 'mock1', url: '', thumbnailUrl: ''),
      PhotoModel(albumId: 1, id: 2, title: 'mock2', url: '', thumbnailUrl: ''),
      PhotoModel(albumId: 1, id: 3, title: 'mock3', url: '', thumbnailUrl: ''),
    ];

    final widgetTree = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''),
            Locale('ro', ''),
          ],
          debugShowCheckedModeBanner: false,
          title: AppTheming.title,
          theme: AppTheming.appThemeData,
          home: Scaffold(
            body: Container(
              height: 700,
              width: double.infinity,
              child: AlbumPhotosList(photos: mockPhotosList),
            ),
          ),
        ));

    await mockNetworkImagesFor(() => widgetTester.pumpWidget(widgetTree));

    final widgetFinder = find.byType(AlbumPhotosList);
    final photoTileFinder = find.byType(PhotoTile);
    final universalAppDividerFinder = find.byType(UniversalAppDivider);

    expect(photoTileFinder, findsNWidgets(mockPhotosList.length));
    expect(universalAppDividerFinder, findsNWidgets(mockPhotosList.length));
    expect(widgetFinder, findsOneWidget);
  });
}

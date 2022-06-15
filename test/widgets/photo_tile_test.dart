import 'package:albums_mvvm/models/photo_model.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:albums_mvvm/widgets/photo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('Photo tile test, should display an image, title, and id',
      (tester) async {
    final PhotoModel mockPhotoModel = PhotoModel(
        albumId: 1, id: 2, title: 'mockPhoto', url: '', thumbnailUrl: '');

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
              height: 600,
              width: double.infinity,
              child: PhotoTile(mockPhotoModel),
            ),
          ),
        ));

    await mockNetworkImagesFor(() => tester.pumpWidget(widgetTree));

    final titleFinder = find.textContaining(mockPhotoModel.title);
    final idFinder = find.textContaining(mockPhotoModel.id.toString());
    final widgetFinder = find.byType(PhotoTile);
    final photoFinder = find.byType(Image);
    final foundTextTitleWidget = tester.firstWidget(titleFinder) as Text;

    expect(foundTextTitleWidget.style!.fontFamily, AppTheming.fontFamily);
    expect(foundTextTitleWidget.style!.color, AppTheming.primaryColor);
    expect(foundTextTitleWidget.style!.fontSize, AppTheming.headline4.fontSize);

    expect(widgetFinder, findsOneWidget);
    expect(titleFinder, findsOneWidget);
    expect(idFinder, findsOneWidget);

    expect(photoFinder, findsOneWidget);
  });
}

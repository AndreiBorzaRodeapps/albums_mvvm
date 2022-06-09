import 'package:albums_mvvm/models/photo_model.dart';
import 'package:albums_mvvm/theming/app_dimensions.dart';
import 'package:albums_mvvm/widgets/album_details_horizontal_bar.dart';
import 'package:albums_mvvm/widgets/icon_text_button.dart';
import 'package:albums_mvvm/widgets/universal_app_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:albums_mvvm/theming/app_theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets(
      'Horizontal bar : should display 2 IconTextButton widgets and one middle Text with photos count',
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
              height: 600,
              width: double.infinity,
              child: AlbumDetailsHorizontalBar(
                photosTotalNumber: mockPhotosList.length,
              ),
            ),
          ),
        ));

    await widgetTester.pumpWidget(widgetTree);

    final universalAppDividerFinder = find.byType(UniversalAppDivider);
    final iconTextButtonFinder = find.byType(IconTextButton);
    final favoritesIconFinder = find.byIcon(Icons.favorite_border_outlined);
    final commentsIconFinder = find.byIcon(Icons.comment);
    final countTextFinder =
        find.textContaining(mockPhotosList.length.toString());

    final countTextWidget = widgetTester.firstWidget(countTextFinder) as Text;

    expect(universalAppDividerFinder, findsNWidgets(4));
    expect(iconTextButtonFinder, findsNWidgets(2));

    expect(favoritesIconFinder, findsOneWidget);
    expect(commentsIconFinder, findsOneWidget);
    expect(countTextFinder, findsOneWidget);

    expect(countTextWidget.style!.fontSize, AppDimensions.defaultFontSize);
    expect(countTextWidget.style!.fontWeight, FontWeight.bold);
    expect(countTextWidget.style!.color, AppTheming.primaryColor);
  });
}

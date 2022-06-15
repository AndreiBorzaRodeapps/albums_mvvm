import 'package:albums_mvvm/models/album_model.dart';
import 'package:albums_mvvm/theming/app_dimensions.dart';
import 'package:albums_mvvm/widgets/album_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:albums_mvvm/theming/app_theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('Album tile test, should render a text and an icon', (tester) async {
    final mockAlbumModel = AlbumModel(id: 1, userId: 23, title: 'mockTitle');
    const IconData mockIcon = Icons.add;

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
              child: AlbumTile(
                  currentAlbum: mockAlbumModel,
                  onTileTap: () {},
                  icon: mockIcon),
            ),
          ),
        ));

    await tester.pumpWidget(widgetTree);

    final foundIconWidget = tester.firstWidget(find.byIcon(mockIcon)) as Icon;
    final widgetFinder = find.byType(AlbumTile);
    final foundTextTitleWidget =
        tester.firstWidget(find.textContaining(mockAlbumModel.title)) as Text;


    expect(foundTextTitleWidget.style!.fontFamily, AppTheming.fontFamily);
    expect(foundTextTitleWidget.style!.color, AppTheming.primaryColor);
    expect(foundTextTitleWidget.style!.fontSize, AppTheming.headline4.fontSize);

    expect(foundIconWidget.size, AppDimensions.defaultIconSize);
    expect(foundIconWidget.color, AppTheming.primaryColor);

    expect(widgetFinder, findsOneWidget);
  });
}

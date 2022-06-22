import 'package:albums_mvvm/widgets/app_nav_bar.dart';
import 'package:albums_mvvm/widgets/icon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('app nav bar, should display the navi bar with 4 tabs',
      (widgetTester) async {
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
            child: Column(
              children: [
                IconBottomBar(
                    text: 'mock1',
                    icon: Icons.abc,
                    selected: true,
                    onPressed: () {}),
                IconBottomBar(
                  text: 'mock2',
                  icon: Icons.add,
                  onPressed: () {},
                  selected: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    await widgetTester.pumpWidget(widgetTree);

    final iconBottomBarFinder = find.byType(IconBottomBar);
    final textFinder1 = find.textContaining('mock1');
    final textFinder2 = find.textContaining('mock2');
    final iconFinder1 = find.byIcon(Icons.abc);
    final iconFinder2 = find.byIcon(Icons.add);

    final textFinderSelected = widgetTester.firstWidget(
        find.byKey(const ValueKey('iconBottomBar: mock1-text'))) as Text;
    final textFinderUnselected = widgetTester.firstWidget(
        find.byKey(const ValueKey('iconBottomBar: mock2-text'))) as Text;

    expect(iconBottomBarFinder, findsNWidgets(2));
    expect(textFinder1, findsOneWidget);
    expect(textFinder2, findsOneWidget);
    expect(iconFinder1, findsOneWidget);
    expect(iconFinder2, findsOneWidget);

    expect(textFinderSelected.style, AppTheming.selectedLabelStyle);
    expect(textFinderUnselected.style, AppTheming.unselectedLabelStyle);
  });
}

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
            child: BottomNavBar(changeTabFn: () {}, totalTabs: 4),
          ),
        ),
      ),
    );

    await widgetTester.pumpWidget(widgetTree);

    final bottomNavBarFinder = find.byType(BottomNavBar);
    final iconBottomBarFinder = find.byType(IconBottomBar);
    final browseIconFinder = find.byIcon(Icons.search);
    final friendsIconFinder = find.byIcon(Icons.emoji_emotions_outlined);
    final newsIconFinder = find.byIcon(Icons.file_copy_outlined);
    final profileIconFinder = find.byIcon(Icons.account_circle_outlined);

    expect(bottomNavBarFinder, findsOneWidget);
    expect(iconBottomBarFinder, findsNWidgets(4));
    expect(browseIconFinder, findsOneWidget);
    expect(friendsIconFinder, findsOneWidget);
    expect(newsIconFinder, findsOneWidget);
    expect(profileIconFinder, findsOneWidget);
  });
}

import 'package:albums_mvvm/screens/album_list/albums_list_screen.dart';
import 'package:albums_mvvm/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

import 'package:albums_mvvm/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('app flow test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.byType(MySplashScreen), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.byType(AlbumsListScreen), findsOneWidget);
      expect(find.textContaining('My Albums'), findsOneWidget);

      final findFirstTile = find.byKey(const Key('tile-Album with id: 13'));
      expect(findFirstTile, findsOneWidget);

      //if albumId is even, after tap should display it's details screen
      await tester.drag(findFirstTile, const Offset(0, -500.0));
      await tester.pumpAndSettle();

      final widget54 = find.byKey(const Key('tile-Album with id: 54'));
      expect(widget54, findsOneWidget);

      final goToDetailsWidget54 = find.byKey(const Key('details-Album with id: 54'));
      expect(goToDetailsWidget54, findsOneWidget);

      await tester.tap(goToDetailsWidget54);
      await tester.pumpAndSettle();

      final findBackButton = find.textContaining('Back');
      expect(findBackButton, findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      await tester.tap(findBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(AlbumsListScreen), findsOneWidget);
    });
  });
}

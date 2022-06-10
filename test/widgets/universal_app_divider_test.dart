import 'package:albums_mvvm/widgets/universal_app_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Universal app divider test, should get displayed',
      (widgetTester) async {
    final widgetTree = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: Container(
              height: 200,
              width: 200,
              child: UniversalAppDivider(),
            ),
          ),
        ));

    await widgetTester.pumpWidget(widgetTree);

    final dividerFinder = find.byType(UniversalAppDivider);

    expect(dividerFinder, findsOneWidget);
  });

  testWidgets('vertical test', (widgetTester) async {
    final widgetTree = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: Scaffold(
            body: Container(
              height: 200,
              width: 200,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  UniversalAppDivider(vertical: true),
                ],
              ),
            ),
          ),
        ));

    await widgetTester.pumpWidget(widgetTree);

    final dividerFinder = find.byType(UniversalAppDivider);

    expect(dividerFinder, findsOneWidget);
  });
}

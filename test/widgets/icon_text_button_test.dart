import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:albums_mvvm/widgets/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Icon text button test, should find an icon and a text', (widgetTester) async {
    const String mockText = 'mockText';
    const IconData mockIcon = Icons.add;

    final widgetTree = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          title: AppTheming.title,
          theme: AppTheming.appThemeData,
          home: Scaffold(
            body: Container(
              height: 600,
              width: double.infinity,
              child:
                  IconTextButton(text: mockText, icon: mockIcon, onTap: () {}),
            ),
          ),
        ));

    await widgetTester.pumpWidget(widgetTree);

    final textFinder = find.text(mockText);
    final iconFinder = find.byIcon(mockIcon);
    final widgetFinder = find.byType(IconTextButton);

    expect(textFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
    expect(widgetFinder, findsOneWidget);
  });
}

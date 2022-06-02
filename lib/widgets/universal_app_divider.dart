import 'package:flutter/material.dart';

class UniversalAppDivider extends StatelessWidget {
  final bool vertical;

  UniversalAppDivider({this.vertical = false});

  @override
  Widget build(BuildContext context) {
    return vertical == true
        ? VerticalDivider(thickness: 1)
        : Divider(thickness: 1);
  }
}

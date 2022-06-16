import 'package:flutter/material.dart';

import '../theming/app_dimensions.dart';
import '../theming/app_theme.dart';

class IconBottomBar extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  IconBottomBar({
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          splashRadius: 1,
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: AppDimensions.defaultIconSize,
            color: selected
                ? AppTheming.selectedNavigationLabelColor
                : AppTheming.unselectedNavigationLabelColor,
          ),
        ),
        Text(
          text,
          style: selected
              ? AppTheming.selectedLabelStyle
              : AppTheming.unselectedLabelStyle,
        ),
      ],
    );
  }
}

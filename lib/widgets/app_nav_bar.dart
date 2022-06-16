import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../theming/app_dimensions.dart';
import '../theming/app_theme.dart';
import 'icon_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  final Function changeTabFn;
  final int totalTabs;

  BottomNavBar({required this.changeTabFn, required this.totalTabs});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void changeSelectedBar(int newValue) {
    setState(() {
      _selectedIndex = newValue;
      widget.changeTabFn(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: AppDimensions.smallPadding),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: AppTheming.linearGradientsColors),
      ),
      // height: AppDimensions.defaultNavigationBarHeight,
      child: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: AppDimensions.defaultNavigationBarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconBottomBar(
                  text: AppLocalizations.of(context)!.browse,
                  icon: Icons.search,
                  selected: _selectedIndex == 0,
                  onPressed: () {
                    changeSelectedBar(0);
                  },
                ),
                IconBottomBar(
                  text: AppLocalizations.of(context)!.friends,
                  icon: Icons.emoji_emotions_outlined,
                  selected: _selectedIndex == 1,
                  onPressed: () {
                    changeSelectedBar(1);
                  },
                ),
                IconBottomBar(
                  text: AppLocalizations.of(context)!.news,
                  icon: Icons.file_copy_outlined,
                  selected: _selectedIndex == 2,
                  onPressed: () {
                    changeSelectedBar(2);
                  },
                ),
                IconBottomBar(
                  text: AppLocalizations.of(context)!.profile,
                  icon: Icons.account_circle_outlined,
                  selected: _selectedIndex == 3,
                  onPressed: () {
                    changeSelectedBar(3);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:albums_mvvm/theming/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import '../../theming/app_theme.dart';
import '../main_screen.dart';
import '../../theming/app_images.dart';

class MySplashScreen extends StatelessWidget {
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: MainScreen(),
      duration: AppDimensions.defaultSplashScreenDuration,
      imageSrc: AppImages.logoBackgroundless,
      backgroundColor: AppTheming.backgroundColor,
      imageSize: AppDimensions.defaultSplashScreenImageSize,
    );
  }
}

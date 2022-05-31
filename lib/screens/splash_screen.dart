import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import '../screens/main_screen.dart';
import '../theming/app_images.dart';

class MySplashScreen extends StatelessWidget {
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: MainScreen(),
      duration: 2000,
      imageSrc: AppImages.splashPhoto,
      backgroundColor: Colors.white,
      imageSize: 300,
    );
  }
}

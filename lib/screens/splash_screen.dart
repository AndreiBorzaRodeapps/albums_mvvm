import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import '../screens/main_screen.dart';

class MySplashScreen extends StatelessWidget {
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: MainScreen(),
      duration: 2000,
      imageSrc: 'assets/images/splash_photo.png',
      backgroundColor: Colors.white,
      imageSize: 300,
    );
  }
}

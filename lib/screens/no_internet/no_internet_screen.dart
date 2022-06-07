import 'package:albums_mvvm/screens/main_screen.dart';
import 'package:albums_mvvm/theming/app_dimensions.dart';
import 'package:flutter/material.dart';
import '../../theming/app_images.dart';
import '../../theming/app_theme.dart';

class NoInternetScreen extends StatelessWidget {
  static const routeName = '/no-internet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Albums'),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: AppDimensions.xxxlPadding),
            child: Column(
              children: <Widget>[
                Image.asset(AppImages.noInternetPhoto),
                SizedBox(height: 40),
                Text(
                  'Whoops!',
                  style: AppTheming.headline6,
                ),
                const SizedBox(height: AppDimensions.defaultPadding),
                Text('It seems that you\'re not connected to the internet!'),
                Text('Please try again!'),
                SizedBox(height: AppDimensions.defaultImageHeight),
                Container(
                  width: 150,
                  child: RaisedButton(
                    onPressed: () {
                      // checkConnection();
                      Navigator.of(context)
                          .pushReplacementNamed(MainScreen.routeName);
                    },
                    child: Text('Try again'),
                    color: AppTheming.altScreenPrimaryColor,
                    textColor: AppTheming.altScreenAccentColor,
                  ),
                ),
              ],
            ),
          ),
          color: AppTheming.altScreenAccentColor,
        ),
      ),
    );
  }
}

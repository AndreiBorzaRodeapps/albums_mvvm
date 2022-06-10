import 'package:albums_mvvm/models/user_model.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:flutter/material.dart';

import '../../theming/app_dimensions.dart';
import '../../widgets/album_tile.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  final UserModel currentUser;

  ProfileScreen({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your profile'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.defaultPadding),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: AppDimensions.avatarRadius,
                child: Text(
                  currentUser.firstCharacter,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            Text(
              currentUser.lastName != 'Unknown'
                  ? '${currentUser.firstName} ${currentUser.lastName}'
                  : 'Unknown',
              style: AppTheming.userProfileHeadline,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.smallPadding),
              child: Text(
                currentUser.lastName != 'Unknown'
                    ? 'Member since 2015'
                    : 'Not a member',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            AlbumTile(
              title: 'Contact Info',
              subTitle: currentUser.lastName == 'Unknown'
                  ? ' '
                  : 'Email address: ${currentUser.emailAddress}',
              icon: Icons.account_circle,
              onTileTap: () {},
            )
          ],
        ),
      ),
    );
  }
}

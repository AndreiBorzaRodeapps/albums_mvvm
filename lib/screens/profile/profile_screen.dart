import 'package:albums_mvvm/models/user_model.dart';
import 'package:albums_mvvm/screens/profile/create_user_screen.dart';
import 'package:albums_mvvm/screens/profile/create_user_viewmodel.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:flutter/material.dart';

import '../../theming/app_dimensions.dart';
import '../../widgets/album_tile.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userVM = CreateUserViewModel();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

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
      body: FutureBuilder<dynamic>(
        future: userVM.fetchLocalUser(),
        builder: (ctx, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.defaultPadding),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: AppDimensions.avatarRadius,
                          child: Text(
                            snapshot.data.firstCharacter,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                      ),
                      Text(
                        snapshot.data.lastName != 'Unknown'
                            ? '${snapshot.data.firstName} ${snapshot.data.lastName}'
                            : 'Unknown',
                        style: AppTheming.userProfileHeadline,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.smallPadding),
                        child: Text(
                          snapshot.data.isUnknown
                              ? 'Not a member'
                              : 'Member since 2015',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      AlbumTile(
                        title: 'Contact Info',
                        subTitle: snapshot.data.lastName == 'Unknown'
                            ? ' '
                            : 'Email address: ${snapshot.data.emailAddress}',
                        icon: Icons.account_circle,
                        onTileTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => CreateUserScreen(
                                currentUser: snapshot.data,
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}

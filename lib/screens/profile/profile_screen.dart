import 'package:albums_mvvm/screens/profile/create_user/create_user_screen.dart';
import 'package:albums_mvvm/screens/profile/profile_viewmodel.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../theming/app_dimensions.dart';
import '../../widgets/album_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModel profileVM;

  @override
  void initState() {
    super.initState();
    profileVM = ProfileViewModel(Input(BehaviorSubject()));
    profileVM.input.loadUser.add(true);
  }

  Widget _buildSProfileScreen(ProfileScreenState profileState) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.defaultPadding),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: AppDimensions.avatarRadius,
              child: Text(
                profileState.displayAvatar,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          Text(
            profileState.fullName(context),
            style: AppTheming.userProfileHeadline,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.smallPadding),
            child: Text(
              profileState.memberSince(context),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          AlbumTile(
            title: AppLocalizations.of(context)!.contactInfo,
            subTitle: profileState.emailAddress(context),
            icon: profileState.displayIcon,
            onTileTap: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (ctx) => CreateUserScreen(),
                ),
              )
                  .then((_) {
                profileVM.input.loadUser.add(true);
              });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.yourProfile),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: StreamBuilder<ProfileScreenState>(
        stream: profileVM.output.outStream,
        builder: (ctx, AsyncSnapshot<ProfileScreenState> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : _buildSProfileScreen(snapshot.data!);
        },
      ),
    );
  }
}

import 'dart:async';

import 'package:albums_mvvm/models/user_model.dart';
import 'package:albums_mvvm/screens/profile/create_user/create_user_screen.dart';
import 'package:albums_mvvm/screens/profile/profile_viewmodel.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../models/input_model.dart';
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
    profileVM = ProfileViewModel(Input(PublishSubject()));
    super.initState();
  }

  Widget _buildSProfileScreen(ProfileScreenState? profileState) {
    profileState ??= ProfileScreenState(ProfileState.unknown);

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
                profileState.profileState == ProfileState.unknown
                    ? '?'
                    : profileState.sendUser!.firstCharacter,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          Text(
            profileState.profileState != ProfileState.unknown
                ? '${profileState.sendUser!.firstName} ${profileState.sendUser!.lastName}'
                : AppLocalizations.of(context)!.unknown,
            style: AppTheming.userProfileHeadline,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.smallPadding),
            child: Text(
              profileState.profileState == ProfileState.unknown
                  ? AppLocalizations.of(context)!.notAMember
                  : '${AppLocalizations.of(context)!.memberSince} ${DateTime.now().year}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          AlbumTile(
            title: AppLocalizations.of(context)!.contactInfo,
            subTitle: profileState.profileState == ProfileState.unknown
                ? ' '
                : '${AppLocalizations.of(context)!.emailAddress}: ${profileState.sendUser!.emailAddress}',
            icon: profileState.profileState == ProfileState.unknown
                ? Icons.account_circle
                : Icons.list_alt_sharp,
            onTileTap: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (ctx) => CreateUserScreen(),
                ),
              )
                  .then((user) async {
                if (user != null)
                  print('Received from create/edit screen:  ${user.toJson()}');
                else
                  print('Received delete user');
                profileVM.input.subject.add(true);
              });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // it only updates after pressing the notifications button
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.yourProfile),
        actions: [
          IconButton(
            onPressed: () {
              profileVM.input.subject.add(true);
            },
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: StreamBuilder<ProfileScreenState>(
        stream: profileVM.output.stream,
        builder: (ctx, AsyncSnapshot<ProfileScreenState> snapshot) {
          return _buildSProfileScreen(snapshot.data);
        },
      ),
    );
  }
}

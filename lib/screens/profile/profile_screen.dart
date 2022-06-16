import 'dart:async';

import 'package:albums_mvvm/models/user_model.dart';
import 'package:albums_mvvm/screens/profile/create_user/create_user_screen.dart';
import 'package:albums_mvvm/screens/profile/profile_viewmodel.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../../theming/app_dimensions.dart';
import '../../widgets/album_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'create_user/create_user_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileViewModel profileVM;
  ProfileScreenState? _profileState;
  List<StreamSubscription> _subscriptions = [];

  @override
  void dispose() {
    _subscriptions.forEach((element) {
      element.cancel();
    });
    _subscriptions.clear();
    super.dispose();
  }

  @override
  void initState() {
    profileVM = ProfileViewModel(Input(PublishSubject()));
    _subscriptions.add(
      profileVM.output.stream.listen(
        (profileScreenState) {
          setState(() {
            print('Received: $profileScreenState');
            _profileState = profileScreenState;
          });
        },
      ),
    );
    profileVM.input.loadUser.add(true);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget _buildSProfileScreen({UserModel? user}) {
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
                user == null ? '?' : user.firstCharacter,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
          Text(
            user != null
                ? '${user.firstName} ${user.lastName}'
                : AppLocalizations.of(context)!.unknown,
            style: AppTheming.userProfileHeadline,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppDimensions.smallPadding),
            child: Text(
              user == null
                  ? AppLocalizations.of(context)!.notAMember
                  : '${AppLocalizations.of(context)!.memberSince} ${DateTime.now().year}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          AlbumTile(
            title: AppLocalizations.of(context)!.contactInfo,
            subTitle: user == null
                ? ' '
                : '${AppLocalizations.of(context)!.emailAddress}: ${user.emailAddress}',
            icon: user == null ? Icons.account_circle : Icons.list_alt_sharp,
            onTileTap: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (ctx) => CreateUserScreen(
                    currentUser: user,
                  ),
                ),
              )
                  .then((user) async {
                if (user != null)
                  print('Received from create/edit screen:  ${user.toJson()}');
                else
                  print('Received delete user');

                profileVM.updateUser(user);
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
            onPressed: () {
              profileVM.input.loadUser.add(true);
            },
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: _profileState == null
          ? const Center(child: CircularProgressIndicator())
          : (_profileState!.profileState == ProfileState.unknown
              ? _buildSProfileScreen()
              : _buildSProfileScreen(user: _profileState!.sendUser)),
    );
  }
}

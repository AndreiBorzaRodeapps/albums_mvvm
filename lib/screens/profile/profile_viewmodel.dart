import 'dart:async';
import 'package:albums_mvvm/repository/user_repository.dart';

import '../../models/user_model.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum ProfileState { unknown, user }

class ProfileScreenState {
  final ProfileState profileState;
  UserModel? sendUser;

  ProfileScreenState(this.profileState, {this.sendUser});

  String fullName(BuildContext ctx) {
    return profileState == ProfileState.unknown
        ? AppLocalizations.of(ctx)!.unknown
        : '${sendUser!.firstName} ${sendUser!.lastName}';
  }

  String emailAddress(BuildContext ctx) {
    return profileState == ProfileState.unknown
        ? ''
        : '${AppLocalizations.of(ctx)!.emailAddress}: ${sendUser!.emailAddress}';
  }

  String get displayAvatar {
    return profileState == ProfileState.unknown
        ? '?'
        : sendUser!.firstCharacter;
  }

  String memberSince(BuildContext ctx) {
    return profileState == ProfileState.unknown
        ? AppLocalizations.of(ctx)!.notAMember
        : '${AppLocalizations.of(ctx)!.memberSince} ${DateTime.now().year}';
  }

  IconData get displayIcon {
    return profileState == ProfileState.unknown
        ? Icons.account_circle
        : Icons.list_alt_sharp;
  }
}

class ProfileViewModel {
  final UserRepository _userRepo;
  final Input input;
  late Output output;

  ProfileViewModel(this.input, {UserRepository? userRepository})
      : _userRepo = userRepository ?? UserRepository() {
    output = Output(_getProfileScreenState());
  }

  Stream<ProfileScreenState> _getProfileScreenState() => input.loadUser.flatMap(
        (_) => _userRepo.fetchLocalUser().map(
              (user) => user == null
                  ? ProfileScreenState(ProfileState.unknown)
                  : ProfileScreenState(ProfileState.user, sendUser: user),
            ),
      );
}

class Input {
  final BehaviorSubject<bool> loadUser;

  Input(this.loadUser);
}

class Output {
  final Stream<ProfileScreenState> outStream;

  Output(this.outStream);
}

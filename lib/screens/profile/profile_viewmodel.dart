import 'dart:async';
import 'package:albums_mvvm/repository/user_repository.dart';
import 'package:flutter/foundation.dart';

import '../../models/input_model.dart';
import '../../models/output_model.dart';
import '../../models/user_model.dart';
import 'package:rxdart/rxdart.dart';

enum ProfileState { unknown, user }

class ProfileScreenState {
  final ProfileState profileState;
  UserModel? sendUser;

  ProfileScreenState(this.profileState, {this.sendUser});
}

class ProfileViewModel {
  final UserRepository _userRepo;
  final Input input;
  late Output<ProfileScreenState> output;

  ProfileViewModel(this.input, {UserRepository? userRepository})
      : _userRepo = userRepository ?? UserRepository() {
    output = Output<ProfileScreenState>(_getProfileScreenState());
  }

  Stream<ProfileScreenState> _getProfileScreenState() => input.subject.flatMap(
        (_) => _userRepo.fetchLocalUser().map(
              (user) => user == null
                  ? ProfileScreenState(ProfileState.unknown)
                  : ProfileScreenState(ProfileState.user, sendUser: user),
            ),
      );
}

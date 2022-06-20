import 'dart:async';
import 'package:albums_mvvm/repository/user_repository.dart';

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
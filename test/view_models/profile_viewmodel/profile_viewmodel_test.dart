import 'package:albums_mvvm/models/user_model.dart';
import 'package:albums_mvvm/repository/user_repository.dart';
import 'package:albums_mvvm/screens/profile/profile_screen/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('profile vm tests', () {
    final profileVM = ProfileViewModel(Input(BehaviorSubject()));
    final userRepo = UserRepository();
    final UserModel mockUser = UserModel(
      firstName: 'mockName',
      lastName: 'mockLastName',
      emailAddress: 'mock@test.com',
      phoneNumber: '12345678',
      userAddress: UserAddress(
          streetAddress: 'mock',
          zipcode: '999999',
          city: 'MockCity',
          country: 'MockCountry'),
    );
    WidgetsFlutterBinding.ensureInitialized();

    test('fetching user state - there is a user in local storage', () {
      profileVM.input.loadUser.add(true);
      SharedPreferences.setMockInitialValues({'user': mockUser.toJson()});

      expect(
          profileVM.output.outStream,
          emitsInOrder([
            ProfileScreenState(ProfileState.user, sendUser: mockUser),
          ]));
    });

    test('fetching unknown state - there is no user in local storage', () {
      SharedPreferences.setMockInitialValues({});

      profileVM.input.loadUser.add(true);
      expect(profileVM.output.outStream,
          emitsInOrder([ProfileScreenState(ProfileState.unknown)]));
    });
    test('profile screen state functions', () {
      final unknownProfileScreenState =
          ProfileScreenState(ProfileState.unknown);
      final userProfileScreenState =
          ProfileScreenState(ProfileState.user, sendUser: mockUser);

      expect(unknownProfileScreenState.sendUser, null);
      expect(unknownProfileScreenState.profileState, ProfileState.unknown);
      expect(unknownProfileScreenState.displayIcon, Icons.account_circle);
      expect(unknownProfileScreenState.displayAvatar, '?');
      // TODO: can this be tested? expect(unknownProfileScreenState.fullName(mockContext ???), 'Unknown');

      expect(userProfileScreenState.sendUser, mockUser);
      expect(userProfileScreenState.profileState, ProfileState.user);
      expect(userProfileScreenState.displayIcon, Icons.list_alt_sharp);
      expect(userProfileScreenState.displayAvatar, mockUser.firstCharacter);
    });

    //endgroup
  });
}

import 'dart:math';

import 'package:albums_mvvm/models/user_model.dart';
import 'package:albums_mvvm/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('user repo resting', () {
    final userRepo = UserRepository();
    final expectedUser = UserModel(
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
    test('available user should be found', () {
      SharedPreferences.setMockInitialValues({'user': expectedUser.toJson()});

      expect(userRepo.fetchLocalUser(), emitsInOrder([expectedUser]));
    });
    test('no user should be found', () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove('user');

      expect(userRepo.fetchLocalUser(), emitsInOrder([null]));
    });

    //endgroup
  });
}

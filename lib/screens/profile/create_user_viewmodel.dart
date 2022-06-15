import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

//TODO: REDO LOGIC!

class CreateUserViewModel {
  UserModel _currentUser = UserModel.unknown();
  bool _canSubmit = true;

  UserModel get currentUser {
    return _currentUser;
  }

  Future<UserModel> fetchLocalUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? string = prefs.getString('user');

    if (string != null) {
      final data = json.decode(string);
      _currentUser = UserModel(
        firstName: data['firstName'],
        lastName: data['lastName'],
        emailAddress: data['emailAddress'],
        phoneNumber: data['phoneNumber'],
        userAddress: UserAddress(
          streetAddress: data['streetAddress'],
          city: data['city'],
          country: data['country'],
          zipcode: data['zipcode'],
        ),
      );
    }

    return _currentUser;
  }

  Future<void> deleteUser() async {
    await setLocalUser(UserModel.unknown());
    _currentUser = UserModel.unknown();
  }

  Future<void> setLocalUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('user');
    prefs.setString(
        'user',
        json.encode({
          'firstName': user.firstName,
          'lastName': user.lastName,
          'emailAddress': user.emailAddress,
          'phoneNumber': user.phoneNumber,
          'streetAddress': user.userAddress.streetAddress,
          'city': user.userAddress.city,
          'country': user.userAddress.country,
          'zipcode': user.userAddress.zipcode,
        }));

    _currentUser = user;
  }

  Map<String, bool> checkControllersAndUpdateUI({
    required TextEditingController firstName,
    required TextEditingController lastName,
    required TextEditingController emailAddress,
    required TextEditingController phoneNumber,
    required TextEditingController streetAddress,
    required TextEditingController city,
    required TextEditingController country,
    required TextEditingController zipcode,
  }) {
    Map<String, bool> resultMap = {
      'firstName': false,
      'lastName': false,
      'emailAddress': false,
      'phoneNumber': false,
      'streetAddress': false,
      'city': false,
      'country': false,
      'zipcode': false,
    };
    if (firstName.text.isEmpty) {
      resultMap['firstName'] = true;
      _canSubmit = false;
    }
    if (lastName.text.isEmpty) {
      resultMap['lastName'] = true;
      _canSubmit = false;
    }
    if (emailAddress.text.isEmpty) {
      resultMap['emailAddress'] = true;
      _canSubmit = false;
    }
    if (phoneNumber.text.isEmpty) {
      resultMap['phoneNumber'] = true;
      _canSubmit = false;
    }
    if (streetAddress.text.isEmpty) {
      resultMap['streetAddress'] = true;
      _canSubmit = false;
    }
    if (city.text.isEmpty) {
      resultMap['city'] = true;
      _canSubmit = false;
    }
    if (country.text.isEmpty) {
      resultMap['country'] = true;
      _canSubmit = false;
    }
    if (zipcode.text.isEmpty) {
      resultMap['zipcode'] = true;
      _canSubmit = false;
    }

    return resultMap;
  }

  String get emptyFormText {
    return 'Required';
  }

  bool get canSubmit {
    return _canSubmit;
  }
}

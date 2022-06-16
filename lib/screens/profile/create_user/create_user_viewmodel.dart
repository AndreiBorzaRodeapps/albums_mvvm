import 'dart:async';

import 'package:albums_mvvm/repository/user_repository.dart';
import 'package:flutter/material.dart';
import '../../../models/user_model.dart';

class CreateUserViewModel {
  final UserRepository _userRepo;
  bool _canSubmit = true;
  UserModel? _currentUser;
  final RegExp nameRegExp = RegExp('[a-zA-Z]');
  final RegExp numberRegExp = RegExp(r'\d');
  final RegExp emailRegExp = RegExp('[a-zA-Z]+@[a-zA-Z]+.[a-zA-Z]');

  CreateUserViewModel({UserRepository? userRepository})
      : _userRepo = userRepository ?? UserRepository();

  void deleteUser() {
    _userRepo.setLocalUser(null);
  }

  Future<UserModel?> fetchUser() async {
    _currentUser = await _userRepo.fetchLocalUser().first;
    return _currentUser;
  }

  void setLocalUser(UserModel? user) {
    _userRepo.setLocalUser(user);
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

  bool validateName(String name) {
    if (name.length < 3) return false;
    if (!nameRegExp.hasMatch(name)) return false;
    if (numberRegExp.hasMatch(name)) return false;
    return true;
  }

  bool validateEmail(String email) {
    return emailRegExp.hasMatch(email);
  }

  bool validateNumber(String number) {
    return numberRegExp.hasMatch(number);
  }

  String get emptyFormText {
    return 'Required';
  }

  bool get canSubmit {
    return _canSubmit;
  }
}

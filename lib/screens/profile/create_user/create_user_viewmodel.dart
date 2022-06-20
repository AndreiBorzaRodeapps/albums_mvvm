import 'dart:async';

import 'package:albums_mvvm/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../models/user_model.dart';

class CreateUserViewModel {
  final UserRepository _userRepo;
  final Input input;
  late Output output;

  bool _canSubmit = true;
  final RegExp _nameRegExp = RegExp('[a-zA-Z]');
  final RegExp _numberRegExp = RegExp(r'\d');
  final RegExp _emailRegExp = RegExp('[a-zA-Z]+@[a-zA-Z]+.[a-zA-Z]');

  CreateUserViewModel(this.input, {UserRepository? userRepository})
      : _userRepo = userRepository ?? UserRepository() {
    output = Output(_getUserModel());
  }

  Stream<UserModel?> _getUserModel() => input.subject
      .flatMap((_) => _userRepo.fetchLocalUser().map((user) => user));

  void deleteUser() {
    _userRepo.setLocalUser(null);
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
    if (!_nameRegExp.hasMatch(name)) return false;
    if (_numberRegExp.hasMatch(name)) return false;
    return true;
  }

  bool validateEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  bool validateNumber(String number) {
    return _numberRegExp.hasMatch(number);
  }

  String get emptyFormText {
    return 'Required';
  }

  bool get canSubmit {
    return _canSubmit;
  }
}

class Input {
  final BehaviorSubject<bool> subject;

  Input(this.subject);
}

class Output {
  final Stream<UserModel?> stream;

  Output(this.stream);
}

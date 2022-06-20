import 'dart:async';

import 'package:albums_mvvm/repository/user_repository.dart';
import 'package:albums_mvvm/screens/profile/create_user/validator.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../models/user_model.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum FieldKey {
  firstName,
  lastName,
  emailAddress,
  phoneNumber,
  streetAddress,
  city,
  country,
  zipcode
}

enum ErrorType {
  none,
  required,
  onlyLetters,
  onlyDigits,
  invalidEmail,
}

enum UserState { create, edit }

class UserScreenState {
  final UserState userState;
  UserModel? user;

  UserScreenState(this.userState, {this.user});
}

class CreateUserViewModel {
  final UserRepository _userRepo;
  final Input input;
  late Output output;
  final Validator validator = Validator();
  bool _canSubmit = true;
  UserScreenState? _userScreenState;

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _street;
  String? _city;
  String? _country;
  String? _zipcode;

  CreateUserViewModel(this.input, {UserRepository? userRepository})
      : _userRepo = userRepository ?? UserRepository() {
    output = Output(_getUserModel());
  }

  Stream<UserScreenState> _getUserModel() => input.subject.flatMap(
        (_) => _userRepo.fetchLocalUser().map(
          (receivedUser) {
            receivedUser == null
                ? _userScreenState = UserScreenState(UserState.create)
                : _userScreenState =
                    UserScreenState(UserState.edit, user: receivedUser);
            return _userScreenState!;
          },
        ),
      );

  void deleteUser() {
    _userRepo.setLocalUser(null);
  }

  void setLocalUser(UserModel? user) {
    _userRepo.setLocalUser(user);
  }

  bool get canSubmit {
    return _canSubmit;
  }

  bool setUserFromCurrentInputs() {
    if (_canSubmit) {
      final user = UserModel(
        firstName: _firstName!,
        lastName: _lastName!,
        emailAddress: _email!,
        phoneNumber: _phone!,
        userAddress: UserAddress(
          country: _country!,
          city: _city!,
          zipcode: _zipcode!,
          streetAddress: _street!,
        ),
      );

      setLocalUser(user);
      return true;
    }
    return false;
  }

  Map<FieldKey, ErrorType> checkInputs({
    required TextEditingController firstName,
    required TextEditingController lastName,
    required TextEditingController email,
    required TextEditingController phone,
    required TextEditingController street,
    required TextEditingController city,
    required TextEditingController country,
    required TextEditingController zipcode,
  }) {
    Map<FieldKey, ErrorType> resultMap = {
      FieldKey.firstName: ErrorType.none,
      FieldKey.lastName: ErrorType.none,
      FieldKey.emailAddress: ErrorType.none,
      FieldKey.phoneNumber: ErrorType.none,
      FieldKey.streetAddress: ErrorType.none,
      FieldKey.city: ErrorType.none,
      FieldKey.country: ErrorType.none,
      FieldKey.zipcode: ErrorType.none,
    };
    _canSubmit = true;

    //firstName checking
    if (firstName.text.isEmpty) {
      resultMap[FieldKey.firstName] = ErrorType.required;
    } else {
      final res = validator.validateName(firstName.text);
      if (!res) {
        resultMap[FieldKey.firstName] = ErrorType.onlyLetters;
      } else {
        _firstName = firstName.text.trim();
      }
    }

    //lastName checking
    if (lastName.text.isEmpty) {
      resultMap[FieldKey.lastName] = ErrorType.required;
    } else {
      final res = validator.validateName(lastName.text);
      if (!res) {
        resultMap[FieldKey.lastName] = ErrorType.onlyLetters;
      } else {
        _lastName = lastName.text.trim();
      }
    }

    //email checking
    if (email.text.isEmpty) {
      resultMap[FieldKey.emailAddress] = ErrorType.required;
    } else {
      final res = validator.validateEmail(email.text);
      if (!res) {
        resultMap[FieldKey.emailAddress] = ErrorType.invalidEmail;
      } else {
        _email = email.text.trim();
      }
    }

    //phone checking
    if (phone.text.isEmpty) {
      resultMap[FieldKey.phoneNumber] = ErrorType.required;
    } else {
      final res = validator.validateNumber(phone.text);
      if (!res) {
        resultMap[FieldKey.phoneNumber] = ErrorType.onlyDigits;
      } else {
        _phone = phone.text.trim();
      }
    }

    //street checking
    if (street.text.isEmpty) {
      resultMap[FieldKey.streetAddress] = ErrorType.required;
    } else {
      _street = street.text.trim();
    }

    //city checking
    if (city.text.isEmpty) {
      resultMap[FieldKey.city] = ErrorType.required;
    } else {
      final res = validator.validateName(city.text);
      if (!res) {
        resultMap[FieldKey.city] = ErrorType.onlyLetters;
      } else {
        _city = city.text.trim();
      }
    }

    //country checking
    if (country.text.isEmpty) {
      resultMap[FieldKey.country] = ErrorType.required;
    } else {
      final res = validator.validateName(country.text);
      if (!res) {
        resultMap[FieldKey.country] = ErrorType.onlyLetters;
      } else {
        _country = country.text.trim();
      }
    }

    //zipcode checking
    if (zipcode.text.isEmpty) {
      resultMap[FieldKey.zipcode] = ErrorType.required;
    } else {
      final res = validator.validateNumber(zipcode.text);
      if (!res) {
        resultMap[FieldKey.zipcode] = ErrorType.onlyDigits;
      } else {
        _zipcode = zipcode.text.trim();
      }
    }

    resultMap.forEach((key, value) {
      if (value != ErrorType.none) _canSubmit = false;
    });

    if (_userScreenState!.userState == UserState.create) {
      if (resultMap[FieldKey.firstName] != ErrorType.none) firstName.text = '';
      if (resultMap[FieldKey.lastName] != ErrorType.none) lastName.text = '';
      if (resultMap[FieldKey.emailAddress] != ErrorType.none) email.text = '';
      if (resultMap[FieldKey.phoneNumber] != ErrorType.none) phone.text = '';
      if (resultMap[FieldKey.streetAddress] != ErrorType.none) street.text = '';
      if (resultMap[FieldKey.city] != ErrorType.none) city.text = '';
      if (resultMap[FieldKey.country] != ErrorType.none) country.text = '';
      if (resultMap[FieldKey.zipcode] != ErrorType.none) zipcode.text = '';
    }

    return resultMap;
  }
}

class Input {
  final BehaviorSubject<bool> subject;

  Input(this.subject);
}

class Output {
  final Stream<UserScreenState> stream;

  Output(this.stream);
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validator {
  final RegExp _nameRegExp = RegExp(r'[a-zA-Z]');
  final RegExp _numberRegExp = RegExp(r'\d');
  final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool validateName(String value) {
    return _nameRegExp.hasMatch(value) && value.length > 3;
  }

  bool validateEmail(String value) {
    return _emailRegExp.hasMatch(value);
  }

  bool validateNumber(String value) {
    return _numberRegExp.hasMatch(value) && value.length > 5;
  }
}

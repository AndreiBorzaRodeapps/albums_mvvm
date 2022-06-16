import 'package:flutter/material.dart';

import '../theming/app_theme.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? errorText;
  final TextInputType? keyboardType;
  final Function onSumbit;
  final String? Function(String?)? validator;

  AppTextFormField({
    required this.controller,
    required this.labelText,
    required this.onSumbit,
    this.errorText,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onFieldSubmitted: (value) {
        onSumbit(value);
      },
      autocorrect: false,
      style: errorText == null
          ? AppTheming.formTextStyle
          : AppTheming.formErrorTextStyle,
      onTap: () {
        if (errorText != null) {
          controller.text = errorText!;
        }
      },
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: errorText == null
            ? AppTheming.formDecorationStyle
            : AppTheming.formErrorStyle,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: errorText == null
                ? AppTheming.primaryColor
                : AppTheming.errorColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: errorText == null
                ? AppTheming.primaryColor
                : AppTheming.errorColor,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: errorText == null
                ? AppTheming.primaryColor
                : AppTheming.errorColor,
          ),
        ),
      ),
    );
  }
}

import 'package:albums_mvvm/theming/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import '../screens/profile/create_user/create_user_viewmodel.dart';
import '../theming/app_theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  late final ErrorType errorType;
  final TextInputType? keyboardType;
  final Function? onSumbit;
  final VoidCallback? onTap;
  final Function(String?)? onChanged;

  AppTextFormField({
    this.onTap,
    required this.controller,
    required this.labelText,
    this.onSumbit,
    required this.errorType,
    required this.onChanged,
    this.keyboardType,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  String? errorText;

  void _setErrorText(BuildContext ctx) {
    switch (widget.errorType) {
      case ErrorType.none:
        errorText = null;
        break;

      case ErrorType.required:
        errorText = AppLocalizations.of(ctx)!.requiredField;
        break;
      case ErrorType.onlyLetters:
        errorText = AppLocalizations.of(ctx)!.onlyLetter;
        break;
      case ErrorType.onlyDigits:
        errorText = AppLocalizations.of(ctx)!.onlyDigits;
        break;
      case ErrorType.invalidEmail:
        errorText = AppLocalizations.of(ctx)!.invalidEmail;
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _setErrorText(context);

    return Stack(
      children: [
        TextFormField(
          onFieldSubmitted: (value) {
            if (widget.onSumbit != null) widget.onSumbit!(value);
          },
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          autocorrect: false,
          style: errorText == null
              ? AppTheming.formTextStyle
              : AppTheming.formErrorTextStyle,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            labelText: widget.labelText,
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
        ),
        if (widget.errorType != ErrorType.none)
          IgnorePointer(
            ignoring: true,
            child: Padding(
              padding: const EdgeInsets.only(top: AppDimensions.xlPadding),
              child: Text(
                errorText ?? "",
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
            ),
          ),
      ],
    );
  }
}

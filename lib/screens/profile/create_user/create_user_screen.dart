import 'dart:async';

import 'package:albums_mvvm/theming/app_dimensions.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:albums_mvvm/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rxdart/subjects.dart';
import '../../../models/user_model.dart';
import 'create_user_viewmodel.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _form = GlobalKey<FormState>();
  final userVM = CreateUserViewModel(Input(BehaviorSubject()));
  bool canApply = false;
  bool _isInit = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final streetAddressController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final zipcodeController = TextEditingController();

  Map<FieldKey, ErrorType> errorMap = {
    FieldKey.firstName: ErrorType.none,
    FieldKey.lastName: ErrorType.none,
    FieldKey.emailAddress: ErrorType.none,
    FieldKey.phoneNumber: ErrorType.none,
    FieldKey.streetAddress: ErrorType.none,
    FieldKey.city: ErrorType.none,
    FieldKey.country: ErrorType.none,
    FieldKey.zipcode: ErrorType.none,
  };

  @override
  void initState() {
    super.initState();
    userVM.input.subject.add(true);
  }

  void setErrorTypeToDefault(FieldKey key) {
    setState(() {
      errorMap[key] = ErrorType.none;
    });
  }

  void setInitialUser(UserScreenState userState) {
    if (userState.userState == UserState.edit && _isInit == false) {
      _isInit = true;
      final user = userState.user;
      firstNameController.text = user!.firstName;
      lastNameController.text = user.lastName;
      emailAddressController.text = user.emailAddress;
      phoneNumberController.text = user.phoneNumber;
      streetAddressController.text = user.userAddress.streetAddress;
      cityController.text = user.userAddress.city;
      countryController.text = user.userAddress.country;
      zipcodeController.text = user.userAddress.zipcode;
    }
  }

  void validateForm() {
    setState(() {
      errorMap = userVM.checkInputs(
        firstName: firstNameController,
        lastName: lastNameController,
        email: emailAddressController,
        phone: phoneNumberController,
        street: streetAddressController,
        city: cityController,
        country: countryController,
        zipcode: zipcodeController,
      );

      if (userVM.setUserFromCurrentInputs() == true) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.back,
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
          ),
        ),
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.contactInfo,
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: validateForm,
            child: Text(
              AppLocalizations.of(context)!.apply,
              style: AppTheming.applyButtonTheme,
            ),
          ),
        ],
      ),
      body: StreamBuilder<UserScreenState>(
          stream: userVM.output.stream,
          builder: (context, snapshot) {
            UserScreenState state = snapshot.data as UserScreenState;
            setInitialUser(state);
            //
            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: AppTheming.secondaryBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Flexible(
                              child: AppTextFormField(
                                errorType: errorMap[FieldKey.firstName]!,
                                onChanged: (val) {
                                  setErrorTypeToDefault(FieldKey.firstName);
                                },
                                keyboardType: TextInputType.text,
                                controller: firstNameController,
                                labelText: AppLocalizations.of(context)!
                                    .firstNameField,
                              ),
                            ),
                            const SizedBox(width: AppDimensions.xxlPadding),
                            Flexible(
                              child: AppTextFormField(
                                errorType: errorMap[FieldKey.lastName]!,
                                onChanged: (val) {
                                  setErrorTypeToDefault(FieldKey.lastName);
                                },
                                controller: lastNameController,
                                keyboardType: TextInputType.name,
                                labelText:
                                    AppLocalizations.of(context)!.lastNameField,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: AppDimensions.smallPadding),
                          child: AppTextFormField(
                            errorType: errorMap[FieldKey.emailAddress]!,
                            onChanged: (val) {
                              setErrorTypeToDefault(FieldKey.emailAddress);
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: emailAddressController,
                            labelText:
                                AppLocalizations.of(context)!.emailAddressField,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: AppDimensions.smallPadding,
                              bottom: AppDimensions.xxlPadding),
                          child: AppTextFormField(
                            errorType: errorMap[FieldKey.phoneNumber]!,
                            onChanged: (val) {
                              setErrorTypeToDefault(FieldKey.phoneNumber);
                            },
                            keyboardType: TextInputType.phone,
                            labelText:
                                AppLocalizations.of(context)!.phoneNumberField,
                            controller: phoneNumberController,
                          ),
                        ),
                        AppTextFormField(
                          errorType: errorMap[FieldKey.streetAddress]!,
                          onChanged: (val) {
                            setErrorTypeToDefault(FieldKey.streetAddress);
                          },
                          controller: streetAddressController,
                          labelText:
                              AppLocalizations.of(context)!.streetAddressField,
                          keyboardType: TextInputType.text,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: AppTextFormField(
                                errorType: errorMap[FieldKey.city]!,
                                onChanged: (val) {
                                  setErrorTypeToDefault(FieldKey.city);
                                },
                                keyboardType: TextInputType.name,
                                controller: cityController,
                                labelText:
                                    AppLocalizations.of(context)!.cityField,
                              ),
                            ),
                            SizedBox(width: AppDimensions.xxlPadding),
                            Flexible(
                              child: AppTextFormField(
                                errorType: errorMap[FieldKey.country]!,
                                onChanged: (val) {
                                  setErrorTypeToDefault(FieldKey.country);
                                },
                                keyboardType: TextInputType.name,
                                labelText:
                                    AppLocalizations.of(context)!.countryField,
                                controller: countryController,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: AppTextFormField(
                                errorType: errorMap[FieldKey.zipcode]!,
                                onSumbit: validateForm,
                                onChanged: (val) {
                                  setErrorTypeToDefault(FieldKey.zipcode);
                                },
                                labelText:
                                    AppLocalizations.of(context)!.zipcodeField,
                                controller: zipcodeController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Flexible(child: Container()),
                          ],
                        ),
                        const SizedBox(height: AppDimensions.xxxlPadding),
                        RaisedButton(
                          onPressed: () {},
                          elevation: 0,
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.bigBorderRadius,
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.useMyLocation,
                            style: AppTheming.buttonTextTheme,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.defaultPadding),
                        RaisedButton(
                          onPressed: () async {
                            userVM.deleteUser();
                            Navigator.of(context).pop();
                          },
                          elevation: 0,
                          color: Theme.of(context).errorColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.bigBorderRadius,
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.deleteUser,
                            style: AppTheming.buttonTextTheme,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

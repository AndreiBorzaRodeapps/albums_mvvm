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
  bool _isLoading = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final streetAddressController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final zipcodeController = TextEditingController();

  Map<String, bool> isEmpty = {
    'firstName': false,
    'lastName': false,
    'emailAddress': false,
    'phoneNumber': false,
    'streetAddress': false,
    'city': false,
    'country': false,
    'zipcode': false,
  };

  //TODO: validators

  @override
  void initState() {
    super.initState();
    userVM.input.subject.add(true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userVM.input.subject.add(true);
  }

  void setControllerToEmptyError(TextEditingController controller) {
    controller.text = AppLocalizations.of(context)!.requiredField;
  }

  void setInitialUser(UserModel? currentUser) {
    if (currentUser != null) {
      firstNameController.text = currentUser.firstName;
      lastNameController.text = currentUser.lastName;
      emailAddressController.text = currentUser.emailAddress;
      phoneNumberController.text = currentUser.phoneNumber;
      streetAddressController.text = currentUser.userAddress.streetAddress;
      cityController.text = currentUser.userAddress.city;
      countryController.text = currentUser.userAddress.country;
      zipcodeController.text = currentUser.userAddress.zipcode;
    }
  }

  void validateForm() {
    setState(() {
      _isLoading = true;
      isEmpty = userVM.checkControllersAndUpdateUI(
        firstName: firstNameController,
        lastName: lastNameController,
        emailAddress: emailAddressController,
        phoneNumber: phoneNumberController,
        streetAddress: streetAddressController,
        city: cityController,
        country: countryController,
        zipcode: zipcodeController,
      );
    });

    if (userVM.canSubmit) {
      final UserModel user = UserModel(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        emailAddress: emailAddressController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        userAddress: UserAddress(
          city: cityController.text.trim(),
          country: countryController.text.trim(),
          streetAddress: streetAddressController.text.trim(),
          zipcode: zipcodeController.text.trim(),
        ),
      );

      setState(() {
        _isLoading = false;
      });
      userVM.setLocalUser(user);
      Navigator.of(context).pop();

      ///
    } else {
      setState(() {
        _isLoading = false;
        if (isEmpty['firstName'] == true) {
          setControllerToEmptyError(firstNameController);
        }
        if (isEmpty['lastName'] == true) {
          setControllerToEmptyError(lastNameController);
        }
        if (isEmpty['emailAddress'] == true) {
          setControllerToEmptyError(emailAddressController);
        }
        if (isEmpty['phoneNumber'] == true) {
          setControllerToEmptyError(phoneNumberController);
        }
        if (isEmpty['streetAddress'] == true) {
          setControllerToEmptyError(streetAddressController);
        }
        if (isEmpty['city'] == true) {
          setControllerToEmptyError(cityController);
        }
        if (isEmpty['country'] == true) {
          setControllerToEmptyError(countryController);
        }
        if (isEmpty['zipcode'] == true) {
          setControllerToEmptyError(zipcodeController);
        }
      });
    }
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
              ))
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<UserModel?>(
              stream: userVM.output.stream,
              builder: (context, snapshot) {
                setInitialUser(snapshot.data);
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
                                  validator: (value) {
                                    bool res = true;
                                    if (value != null) {
                                      res = userVM.validateName(value);
                                    }

                                    return res == true
                                        ? null
                                        : 'Incorrect name';
                                  },
                                  onSumbit: () {},
                                  keyboardType: TextInputType.text,
                                  controller: firstNameController,
                                  labelText: AppLocalizations.of(context)!
                                      .firstNameField,
                                  errorText: isEmpty['firstName'] == false
                                      ? null
                                      : AppLocalizations.of(context)!
                                          .requiredField,
                                )),
                                const SizedBox(width: AppDimensions.xxlPadding),
                                Flexible(
                                  child: AppTextFormField(
                                    onSumbit: () {},
                                    controller: lastNameController,
                                    keyboardType: TextInputType.name,
                                    labelText: AppLocalizations.of(context)!
                                        .lastNameField,
                                    errorText: isEmpty['lastName'] == false
                                        ? null
                                        : AppLocalizations.of(context)!
                                            .requiredField,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: AppDimensions.smallPadding),
                              child: AppTextFormField(
                                onSumbit: () {},
                                keyboardType: TextInputType.emailAddress,
                                controller: emailAddressController,
                                labelText: AppLocalizations.of(context)!
                                    .emailAddressField,
                                errorText: isEmpty['emailAddress'] == false
                                    ? null
                                    : AppLocalizations.of(context)!
                                        .requiredField,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: AppDimensions.smallPadding,
                                  bottom: AppDimensions.xxlPadding),
                              child: AppTextFormField(
                                onSumbit: () {},
                                keyboardType: TextInputType.phone,
                                labelText: AppLocalizations.of(context)!
                                    .phoneNumberField,
                                controller: phoneNumberController,
                                errorText: isEmpty['phoneNumber'] == false
                                    ? null
                                    : AppLocalizations.of(context)!
                                        .requiredField,
                              ),
                            ),
                            AppTextFormField(
                              onSumbit: () {},
                              controller: streetAddressController,
                              labelText: AppLocalizations.of(context)!
                                  .streetAddressField,
                              keyboardType: TextInputType.text,
                              errorText: isEmpty['streetAddress'] == false
                                  ? null
                                  : AppLocalizations.of(context)!.requiredField,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: AppTextFormField(
                                    onSumbit: () {},
                                    keyboardType: TextInputType.name,
                                    controller: cityController,
                                    labelText:
                                        AppLocalizations.of(context)!.cityField,
                                    errorText: isEmpty['city'] == false
                                        ? null
                                        : AppLocalizations.of(context)!
                                            .requiredField,
                                  ),
                                ),
                                SizedBox(width: AppDimensions.xxlPadding),
                                Flexible(
                                  child: AppTextFormField(
                                    onSumbit: () {},
                                    keyboardType: TextInputType.name,
                                    labelText: AppLocalizations.of(context)!
                                        .countryField,
                                    controller: countryController,
                                    errorText: isEmpty['country'] == false
                                        ? null
                                        : AppLocalizations.of(context)!
                                            .requiredField,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: AppTextFormField(
                                    onSumbit: validateForm,
                                    labelText: AppLocalizations.of(context)!
                                        .zipcodeField,
                                    controller: zipcodeController,
                                    keyboardType: TextInputType.number,
                                    errorText: isEmpty['zipcode'] == false
                                        ? null
                                        : AppLocalizations.of(context)!
                                            .requiredField,
                                  ),
                                ),
                                SizedBox(width: 200),
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
                            const SizedBox(
                                height: AppDimensions.defaultPadding),
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
                            RaisedButton(
                              onPressed: () {
                                userVM.input.subject.add(true);
                              },
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

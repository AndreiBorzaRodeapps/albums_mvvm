import 'package:albums_mvvm/screens/profile/create_user_viewmodel.dart';
import 'package:albums_mvvm/theming/app_dimensions.dart';
import 'package:albums_mvvm/theming/app_theme.dart';
import 'package:albums_mvvm/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/user_model.dart';

class CreateUserScreen extends StatefulWidget {
  final UserModel currentUser;

  CreateUserScreen({required this.currentUser});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _form = GlobalKey<FormState>();
  final userViewModel = CreateUserViewModel();
  bool canApply = false;
  final String emptyFormText = 'Required';
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
    setInitialUser();
  }

  void setControllerToEmptyError(TextEditingController controller) {
    controller.text = emptyFormText;
  }

  void setInitialUser() {
    if (!widget.currentUser.isUnknown) {
      firstNameController.text = widget.currentUser.firstName;
      lastNameController.text = widget.currentUser.lastName;
      emailAddressController.text = widget.currentUser.emailAddress;
      phoneNumberController.text = widget.currentUser.phoneNumber;
      streetAddressController.text =
          widget.currentUser.userAddress.streetAddress;
      cityController.text = widget.currentUser.userAddress.city;
      countryController.text = widget.currentUser.userAddress.country;
      zipcodeController.text = widget.currentUser.userAddress.zipcode;
    }
  }

  Future<void> validateForm() async {
    setState(() {
      _isLoading = true;
      isEmpty = userViewModel.checkControllersAndUpdateUI(
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

    if (userViewModel.canSubmit) {
      await userViewModel.setLocalUser(
        UserModel(
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
        ),
      );

      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        Navigator.of(context).pop();
      }
    } else {
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
            'Contact Info',
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          FlatButton(
              onPressed: validateForm,
              child: Text(
                'Apply',
                style: AppTheming.applyButtonTheme,
              ))
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
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
                              onSumbit: () {},
                              keyboardType: TextInputType.text,
                              controller: firstNameController,
                              labelText: 'FIRST NAME',
                              errorText: isEmpty['firstName'] == false
                                  ? null
                                  : emptyFormText,
                            )),
                            SizedBox(width: AppDimensions.xxlPadding),
                            Flexible(
                              child: AppTextFormField(
                                onSumbit: () {},
                                controller: lastNameController,
                                keyboardType: TextInputType.name,
                                labelText: 'LAST NAME',
                                errorText: isEmpty['lastName'] == false
                                    ? null
                                    : emptyFormText,
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
                            labelText: 'EMAIL ADDRESS',
                            errorText: isEmpty['emailAddress'] == false
                                ? null
                                : emptyFormText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: AppDimensions.smallPadding,
                              bottom: AppDimensions.xxlPadding),
                          child: AppTextFormField(
                            onSumbit: () {},
                            keyboardType: TextInputType.phone,
                            labelText: 'PHONE NUMBER',
                            controller: phoneNumberController,
                            errorText: isEmpty['phoneNumber'] == false
                                ? null
                                : emptyFormText,
                          ),
                        ),
                        AppTextFormField(
                          onSumbit: () {},
                          controller: streetAddressController,
                          labelText: 'STREET ADDRESS',
                          keyboardType: TextInputType.text,
                          errorText: isEmpty['streetAddress'] == false
                              ? null
                              : emptyFormText,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: AppTextFormField(
                                onSumbit: () {},
                                keyboardType: TextInputType.name,
                                controller: cityController,
                                labelText: 'CITY',
                                errorText: isEmpty['city'] == false
                                    ? null
                                    : emptyFormText,
                              ),
                            ),
                            SizedBox(width: AppDimensions.xxlPadding),
                            Flexible(
                              child: AppTextFormField(
                                onSumbit: () {},
                                keyboardType: TextInputType.name,
                                labelText: 'COUNTRY',
                                controller: countryController,
                                errorText: isEmpty['country'] == false
                                    ? null
                                    : emptyFormText,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: AppTextFormField(
                                onSumbit: () {},
                                labelText: 'ZIPCODE',
                                controller: zipcodeController,
                                keyboardType: TextInputType.number,
                                errorText: isEmpty['zipcode'] == false
                                    ? null
                                    : emptyFormText,
                              ),
                            ),
                            SizedBox(width: 200),
                          ],
                        ),
                        SizedBox(height: AppDimensions.xxxlPadding),
                        RaisedButton(
                          onPressed: () {},
                          elevation: 0,
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            'Use my location',
                            style: AppTheming.buttonTextTheme,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.bigBorderRadius,
                            ),
                          ),
                        ),
                        SizedBox(height: AppDimensions.defaultPadding),
                        RaisedButton(
                          onPressed: () async {
                            await userViewModel.deleteUser();
                            Navigator.of(context).pop();
                          },
                          elevation: 0,
                          color: Theme.of(context).errorColor,
                          child: Text(
                            'Delete user',
                            style: AppTheming.buttonTextTheme,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.bigBorderRadius,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

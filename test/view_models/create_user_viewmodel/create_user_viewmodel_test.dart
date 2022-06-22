import 'package:albums_mvvm/screens/profile/create_user/create_user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:albums_mvvm/models/user_model.dart';
import 'package:albums_mvvm/repository/user_repository.dart';

void main() {
  group('create/edit user viewmodel testing', () {
    final createUserVM = CreateUserViewModel(Input(BehaviorSubject()));
    final userRepo = UserRepository();
    final UserModel mockUser = UserModel(
      firstName: 'mockName',
      lastName: 'mockLastName',
      emailAddress: 'mock@test.com',
      phoneNumber: '12345678',
      userAddress: UserAddress(
          streetAddress: 'mock',
          zipcode: '999999',
          city: 'MockCity',
          country: 'MockCountry'),
    );
    final UserModel wrongUser = UserModel(
      firstName: '345',
      lastName: '',
      emailAddress: 'abc34.com',
      phoneNumber: '07431dc',
      userAddress: UserAddress(
        country: 'mock',
        city: '353',
        zipcode: '33',
        streetAddress: 'mock',
      ),
    );

    WidgetsFlutterBinding.ensureInitialized();

    test('fetching state - edit state should be sent', () {
      createUserVM.input.subject.add(true);
      SharedPreferences.setMockInitialValues({'user': mockUser.toJson()});

      expect(
          createUserVM.output.stream,
          emitsInOrder([
            UserScreenState(UserState.edit, user: mockUser),
          ]));
    });
    test('fetching state: create state should be sent', () {
      createUserVM.input.subject.add(true);
      SharedPreferences.setMockInitialValues({});

      expect(createUserVM.output.stream,
          emitsInOrder([UserScreenState(UserState.create)]));
    });

    group('vm functions', () {
      test(
          'should check controllers and set a user based on the controllers\' text, if there are no errors',
          () {
        final firstNameController = TextEditingController();
        final lastNameController = TextEditingController();
        final emailAddressController = TextEditingController();
        final phoneNumberController = TextEditingController();
        final streetAddressController = TextEditingController();
        final cityController = TextEditingController();
        final countryController = TextEditingController();
        final zipcodeController = TextEditingController();

        firstNameController.text = mockUser.firstName;
        lastNameController.text = mockUser.lastName;
        emailAddressController.text = mockUser.emailAddress;
        phoneNumberController.text = mockUser.phoneNumber;
        streetAddressController.text = mockUser.userAddress.streetAddress;
        cityController.text = mockUser.userAddress.city;
        countryController.text = mockUser.userAddress.country;
        zipcodeController.text = mockUser.userAddress.zipcode;

        createUserVM.checkInputs(
          firstName: firstNameController,
          lastName: lastNameController,
          email: emailAddressController,
          phone: phoneNumberController,
          street: streetAddressController,
          city: cityController,
          country: countryController,
          zipcode: zipcodeController,
        );

        //test that vm succesfully saves a user from saved controller inputs
        expect(createUserVM.setUserFromCurrentInputs(), true);
      });
      test(
          'should not set a user based on the controllers, some of them are empty or have errors',
          () {
        final firstNameController = TextEditingController();
        final lastNameController = TextEditingController();
        final emailAddressController = TextEditingController();
        final phoneNumberController = TextEditingController();
        final streetAddressController = TextEditingController();
        final cityController = TextEditingController();
        final countryController = TextEditingController();
        final zipcodeController = TextEditingController();

        createUserVM.checkInputs(
          firstName: firstNameController,
          lastName: lastNameController,
          email: emailAddressController,
          phone: phoneNumberController,
          street: streetAddressController,
          city: cityController,
          country: countryController,
          zipcode: zipcodeController,
        );

        expect(createUserVM.setUserFromCurrentInputs(), false);
      });
      test('checkInputs result map: should put every error, if any', () {
        final firstNameController = TextEditingController();
        final lastNameController = TextEditingController();
        final emailAddressController = TextEditingController();
        final phoneNumberController = TextEditingController();
        final streetAddressController = TextEditingController();
        final cityController = TextEditingController();
        final countryController = TextEditingController();
        final zipcodeController = TextEditingController();

        firstNameController.text = wrongUser.firstName;
        //lastname should be left empty for testing!
        emailAddressController.text = wrongUser.emailAddress;
        phoneNumberController.text = wrongUser.phoneNumber;
        streetAddressController.text = wrongUser.userAddress.streetAddress;
        cityController.text = wrongUser.userAddress.city;
        countryController.text = wrongUser.userAddress.country;
        zipcodeController.text = wrongUser.userAddress.zipcode;

        final Map<FieldKey, ErrorType> resMap = createUserVM.checkInputs(
          firstName: firstNameController,
          lastName: lastNameController,
          email: emailAddressController,
          phone: phoneNumberController,
          street: streetAddressController,
          city: cityController,
          country: countryController,
          zipcode: zipcodeController,
        );

        expect(resMap, {
          FieldKey.firstName: ErrorType.onlyLetters,
          FieldKey.lastName: ErrorType.required,
          FieldKey.emailAddress: ErrorType.invalidEmail,
          FieldKey.phoneNumber: ErrorType.onlyDigits,
          FieldKey.streetAddress: ErrorType.none,
          FieldKey.city: ErrorType.onlyLetters,
          FieldKey.country: ErrorType.none,
          FieldKey.zipcode: ErrorType.onlyDigits,
        });

        //should be false: there are errors on inputs
        expect(createUserVM.setUserFromCurrentInputs(), false);
      });

      test('delete user', () {
        createUserVM.deleteUser();
        createUserVM.input.subject.add(true);
        expect(createUserVM.output.stream,
            emitsInOrder([UserScreenState(UserState.create)]));
      });

      //end vm functions
    });

    //endgroup
  });
}

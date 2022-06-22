import 'dart:convert';

class UserAddress {
  final String streetAddress;
  final String city;
  final String country;
  final String zipcode;

  UserAddress({
    required this.streetAddress,
    required this.city,
    required this.country,
    required this.zipcode,
  });

  static const jsonStreetAddres = 'streetAddress';
  static const jsonCity = 'city';
  static const jsonCountry = 'countryString';
  static const jsonZipcode = 'zipcode';

  String toJson() => json.encode({
        jsonStreetAddres: streetAddress,
        jsonCity: city,
        jsonCountry: country,
        jsonZipcode: zipcode,
      });

  factory UserAddress.fromJson(String jason) {
    final addressJson = json.decode(jason);

    return UserAddress(
      streetAddress: addressJson[jsonStreetAddres] as String,
      city: addressJson[jsonCity] as String,
      country: addressJson[jsonCountry] as String,
      zipcode: addressJson[jsonZipcode] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserAddress &&
        other.streetAddress == streetAddress &&
        other.city == city &&
        other.country == country &&
        other.zipcode == zipcode;
  }

  @override
  int get hashCode => int.parse(zipcode);
}

class UserModel {
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String phoneNumber;
  final UserAddress userAddress;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.userAddress,
  });

  static const jsonFirstName = 'firstName';
  static const jsonLastName = 'lastName';
  static const jsonEmailAddress = 'emailAddress';
  static const jsonPhoneNumber = 'phoneNumber';
  static const jsonUserAddress = 'userAddress';

  String toJson() => json.encode({
        jsonFirstName: firstName,
        jsonLastName: lastName,
        jsonEmailAddress: emailAddress,
        jsonPhoneNumber: phoneNumber,
        jsonUserAddress: userAddress.toJson(),
      });

  factory UserModel.fromJson(String jason) {
    final userJson = json.decode(jason);

    return UserModel(
      firstName: userJson[jsonFirstName] as String,
      lastName: userJson[jsonLastName] as String,
      emailAddress: userJson[jsonEmailAddress] as String,
      phoneNumber: userJson[jsonPhoneNumber] as String,
      userAddress: UserAddress.fromJson(userJson['userAddress']),
    );
  }

  String get firstCharacter {
    return firstName[0].toUpperCase();
  }

  @override
  bool operator ==(Object other) {
    return other is UserModel &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.emailAddress == emailAddress &&
        other.phoneNumber == phoneNumber &&
        other.userAddress == userAddress;
  }

  @override
  int get hashCode => int.parse(phoneNumber + userAddress.zipcode);
}

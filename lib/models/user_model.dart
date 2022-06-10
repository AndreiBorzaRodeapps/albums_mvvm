class UserAddress {
  final String streetAddress;
  final String city;
  final String country;
  final String zipCode;

  UserAddress({
    required this.streetAddress,
    required this.city,
    required this.country,
    required this.zipCode,
  });
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

  String get firstCharacter {
    if (lastName != 'Unknown') {
      return firstName[0].toUpperCase();
    }
    return '?';
  }
}

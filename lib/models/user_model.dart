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

  factory UserModel.unknown() => UserModel(
        firstName: 'none',
        lastName: 'Unknown',
        emailAddress: 'none',
        phoneNumber: 'none',
        userAddress: UserAddress(
          streetAddress: 'none',
          city: 'none',
          country: 'none',
          zipcode: 'none',
        ),
      );

  String get firstCharacter {
    if (lastName != 'Unknown') {
      return firstName[0].toUpperCase();
    }
    return '?';
  }

  bool get isUnknown {
    return lastName == 'Unknown';
  }


}

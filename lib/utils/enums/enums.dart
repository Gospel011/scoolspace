import 'package:schoolspace/utils/extensions/string_extension.dart';

enum TextFieldType { password, otp }

enum Role {
  user;

  String get describe => name;

  static Role fromString(String value) {
    switch (value) {
      case 'user':
        return Role.user;
      default:
        return Role.user;
    }
  }
}

enum Gender {
  // select,
  male,
  female;

  String get describe => name.capitalize;

  static Gender fromString(String value) {
    switch(value) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return Gender.male;
    }
  }
}

enum Auth {
  initial,

  loggingIn,
  loggedIn,
  loggingInFailed, signingUp, signedUp, signingUpFailed
}

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

enum Auth {
  initial,

  loggingIn,
  loggedIn,
  loggingInFailed, signingUp, signedUp, signingUpFailed
}

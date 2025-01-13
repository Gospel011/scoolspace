import 'package:schoolspace/utils/extensions/string_extension.dart';

enum AppRoutes {
  signupEmail,
  signupPassword,
  signupVerifyEmail,
  home,
  signupUserInfo, loginPassword, loginEmail;

  String get path => name.kebabCase;
}

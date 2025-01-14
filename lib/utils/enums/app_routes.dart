import 'package:schoolspace/utils/extensions/string_extension.dart';

enum AppRoutes {
  signupEmail,
  signupPassword,
  signupVerifyEmail,
  home,
  signupUserInfo,
  loginPassword,
  loginEmail,
  onboarding, getStarted;

  String get path => name.kebabCase;
}

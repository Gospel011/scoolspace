import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/constants/icon_paths.dart';
import 'package:schoolspace/presentation/auth_pages/signup_verify_email.dart';
import 'package:schoolspace/presentation/widgets/buttons/my_elevated_button.dart';
import 'package:schoolspace/presentation/widgets/my_textformfield.dart';
import 'package:schoolspace/utils/enums/app_routes.dart';
import 'package:schoolspace/utils/enums/enums.dart';
import 'package:schoolspace/utils/extensions/widget_extensions.dart';
import 'package:schoolspace/utils/helpers/logger.dart';
import 'package:schoolspace/utils/validators/validators.dart';

class SignupPassword extends StatefulWidget {
  const SignupPassword({
    super.key,
  });

  @override
  State<SignupPassword> createState() => _SignupPasswordState();
}

class _SignupPasswordState extends State<SignupPassword> {
  final TextEditingController password = TextEditingController();
  bool isValid = true;

  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }

  bool obscureText = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.labelLarge,
            children: const [
              TextSpan(text: "By continuing, you agree to our "),
              TextSpan(
                  text: "Terms of Service ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              TextSpan(text: "and "),
              TextSpan(
                  text: "Privacy Policy.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ).pOnly(bottom: 34.h, left: 60.w, right: 60.w),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // space from top
                SizedBox(
                  height: 32.h,
                ),

                // icon
                SvgPicture.asset(
                  AppIconPaths.logo,
                  width: 50.r,
                  height: 50.r,
                ).pOnly(bottom: 24.h),

                // let's get you all setup
                Text(
                  'Let\'s get you all setup',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ).pOnly(bottom: 8.h),

                // then your password
                Text(
                  'Then, your password. Try something super secure',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ).pOnly(bottom: 20.h),

                // Email TextField
                MyTextFormField(
                  sectionText: "Password",
                  textFieldType: TextFieldType.password,
                  hintText: "Enter your password...",
                  suffixText: obscureText ? "Show" : "Hide",
                  filled: !isValid,
                  fillColor:
                      !isValid
                          ? Colors.red.withValues(alpha: 0.1)
                          : null,
                  onSuffixTextPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  onChanged: (_) => setState(() {
                    isValid = formKey.currentState?.validate() ?? false;
                  }),
                  controller: password,
                  obscureText: obscureText,
                  validator: passwordValidator,
                ).pOnly(bottom: 24.h),

                // Continue button
                MyElevatedButton(
                  text: "Continue",
                  disabled: passwordValidator(password.text) != null,
                  onPressed: () {
                    context.pushNamed(AppRoutes.signupVerifyEmail.name);
                  },
                ).pOnly(bottom: 24.h),

                // Already have an account? login instead
                Center(
                  child: Builder(builder: (context) {
                    final textStyle = Theme.of(context).textTheme.bodySmall;

                    return Wrap(
                      spacing: 4.w,
                      runSpacing: 4.h,
                      children: [
                        Text(
                          "Already have an account",
                          style: textStyle?.copyWith(color: AppColors.charcoal),
                        ),
                        GestureDetector(
                          onTap: () {
                            log.i("Navigate to login");
                          },
                          child: Text("Login instead",
                              style: textStyle?.copyWith(
                                color: AppColors.skyBlue,
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      ],
                    );
                  }),
                ),
              ],
            ).pSymmetric(horizontal: 30.w),
          ),
        ),
      ),
    );
  }
}

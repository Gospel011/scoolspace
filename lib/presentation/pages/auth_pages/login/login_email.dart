import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/constants/icon_paths.dart';
import 'package:schoolspace/presentation/widgets/buttons/my_elevated_button.dart';
import 'package:schoolspace/presentation/widgets/my_textformfield.dart';
import 'package:schoolspace/utils/enums/app_routes.dart';
import 'package:schoolspace/utils/extensions/widget_extensions.dart';
import 'package:schoolspace/utils/helpers/logger.dart';
import 'package:schoolspace/utils/validators/validators.dart';

class LoginEmail extends StatefulWidget {
  const LoginEmail({
    super.key,
  });

  @override
  State<LoginEmail> createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final TextEditingController email =
      TextEditingController(text: '');

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomAppBar(
      //   elevation: 0,
      //   child: RichText(
      //     textAlign: TextAlign.center,
      //     text: TextSpan(
      //       style: Theme.of(context).textTheme.labelLarge,
      //       children: const [
      //         TextSpan(text: "By continuing, you agree to our "),
      //         TextSpan(
      //             text: "Terms of Service ",
      //             style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //             )),
      //         TextSpan(text: "and "),
      //         TextSpan(
      //             text: "Privacy Policy.",
      //             style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //             )),
      //       ],
      //     ),
      //   ).pOnly(bottom: 34.h, left: 60.w, right: 60.w),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // space from top
              SizedBox(
                height: 126.h,
              ),

              // icon
              SvgPicture.asset(
                AppIconPaths.logo,
                width: 50.r,
                height: 50.r,
              ).pOnly(bottom: 24.h),

              //
              Text(
                'Login to Scoolspace',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ).pOnly(bottom: 8.h),

              // 
              Text(
                "Let’s get started with your email",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ).pOnly(bottom: 20.h),

              // Email TextField
              MyTextFormField(
                sectionText: "Email",
                keyboardType: TextInputType.emailAddress,
                hintText: "Enter your email...",
                controller: email,
                onChanged: (_) => setState(() {}),
                validator: emailValidator,
              ).pOnly(bottom: 24.h),

              // Continue button
              MyElevatedButton(
                text: "Continue",
                disabled: !EmailValidator.validate(email.text),
                onPressed: () {
                  context.pushNamed(AppRoutes.loginPassword.name);
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
                        "Don’t have an account?",
                        style: textStyle?.copyWith(color: AppColors.charcoal),
                      ),
                      GestureDetector(
                        onTap: () {
                          log.i("Navigate to login");

                          context.goNamed(AppRoutes.signupEmail.name);
                        },
                        child: Text("Create account",
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
    );
  }
}

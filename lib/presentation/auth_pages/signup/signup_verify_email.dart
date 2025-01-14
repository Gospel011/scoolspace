import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/constants/icon_paths.dart';
import 'package:schoolspace/presentation/widgets/buttons/my_elevated_button.dart';
import 'package:schoolspace/presentation/widgets/buttons/my_text_button.dart';
import 'package:schoolspace/presentation/widgets/my_pin_input.dart';
import 'package:schoolspace/utils/enums/app_routes.dart';
import 'package:schoolspace/utils/extensions/widget_extensions.dart';
import 'package:schoolspace/utils/helpers/logger.dart';
import 'package:schoolspace/utils/helpers/stream_helper.dart';

class SignupVerifyEmail extends StatefulWidget {
  const SignupVerifyEmail({super.key});

  @override
  State<SignupVerifyEmail> createState() => _SignupVerifyEmailState();
}

class _SignupVerifyEmailState extends State<SignupVerifyEmail> {
  final TextEditingController otp = TextEditingController(text: '');

  Timer? timer;
  final StreamHelper timerStream = StreamHelper();
  int seconds = 60;

  @override
  void initState() {
    super.initState();
    sendCode();
  }

  void sendCode() {
    // seconds = 60;
    if (timer?.isActive == true) timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), handleCountDown);
  }

  void handleCountDown(timer) {
    // increment seconds
    seconds -= 1;
    timerStream.add(seconds);
    // log.i("timer called $seconds");

    // check 5 seconds has elapsed
    if (seconds == 0) {
      timer.cancel();

      setState(() {
        canResendCode = true;
      });
    }
  }

  @override
  void dispose() {
    otp.dispose();
    super.dispose();
  }

  bool obscureText = true;
  bool canResendCode = false;

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

              //
              Text(
                'Verify your email',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ).pOnly(bottom: 8.h),

              //
              Text(
                'Enter the security code we sent to sc*******@email.com',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ).pOnly(bottom: 20.h),

              // Email TextField
              MyPinInput(
                controller: otp,
                size: 70.r,
                onChanged: (_) => setState(() {
                  log.i("Otp length: ${otp.text.length}");
                }),
              ).pOnly(bottom: 24.h),

              // Continue button
              MyElevatedButton(
                text: "Continue",
                disabled: otp.text.length != 4,
                onPressed: () {
                  log.i("Otp: ${otp.text}");

                  context.pushNamed(AppRoutes.signupUserInfo.name);
                },
              ).pOnly(bottom: 24.h),

              // Send code again
              Center(
                child: Builder(builder: (context) {
                  final textStyle = Theme.of(context).textTheme.bodySmall;

                  return Wrap(
                    spacing: 4.w,
                    runSpacing: 4.h,
                    children: [
                      MyTextButton(
                        text: "Send code again ",
                        textStyle: textStyle?.copyWith(
                            fontWeight: canResendCode ? FontWeight.bold : null,
                            color: canResendCode ? AppColors.skyBlue : null),
                        onTap: () {
                          if (!canResendCode) return;
                          log.i("Resend code");
                          setState(() {
                            seconds = 60;
                            canResendCode = false;
                            sendCode();
                          });
                        },
                      ),
                      StreamBuilder(
                          stream: timerStream.stream,
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? Text(
                                    "00:${snapshot.data.toString().padLeft(2, '0')}",
                                    style: textStyle?.copyWith(
                                      color: AppColors.onSurfaceColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const SizedBox();
                          })
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

  void toggleCanSendCode() {}
}

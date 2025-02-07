import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/constants/icon_paths.dart';
import 'package:schoolspace/presentation/widgets/buttons/my_elevated_button.dart';
import 'package:schoolspace/presentation/widgets/components/terms_and_conditions.dart';
import 'package:schoolspace/utils/enums/app_routes.dart';
import 'package:schoolspace/utils/extensions/widget_extensions.dart';
import 'package:schoolspace/utils/helpers/logger.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({
    super.key,
  });

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  GlobalKey leadingIconKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: const TermsAndConditions()
            .pOnly(bottom: 34.h, left: 60.w, right: 60.w),
      ),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
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

            // let's get you all setup
            RichText(
              text: TextSpan(
                text: 'Simple school\nsolutions for everyone\nwith ',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  TextSpan(
                      text: 'Scoolspace',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
            ).pOnly(bottom: 8.h),

            const Spacer(),

            MyElevatedButton(
              text: "Get started",
              onPressed: () {
                context.pushNamed(AppRoutes.signupEmail.name);
              },
            ),

            SizedBox(
              height: 16.h,
            ),

            MyElevatedButton(
              text: "Continue with google",
              // mainAxisSize: MainAxisSize.min,
              leadingIconKey: leadingIconKey,
              leadingIcon: SvgPicture.asset(key: leadingIconKey, 'assets/svg/google_logo.svg'),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                context.pushNamed(AppRoutes.signupEmail.name);
              },
            ),

            SizedBox(
              height: 30.h,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    context.pushNamed(AppRoutes.loginEmail.name);
                  },
                  style: ButtonStyle(
                    textStyle: WidgetStatePropertyAll(
                      Theme.of(context).textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: const Text("Login to your account"),
                ),
              ],
            ),

            SizedBox(
              height: 43.h,
            ),
          ],
        ).pSymmetric(horizontal: 30.w),
      ),
    );
  }
}

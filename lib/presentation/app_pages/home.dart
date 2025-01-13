import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/presentation/widgets/buttons/label_button.dart';
import 'package:schoolspace/presentation/widgets/perk_card.dart';
import 'package:schoolspace/utils/enums/pricing_plans.dart';
import 'package:schoolspace/utils/extensions/widget_extensions.dart';
import 'package:schoolspace/utils/helpers/logger.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // spacing from top
              SizedBox(
                height: 80.h,
              ),

              const WelcomeText().pOnly(
                left: 30.w,
                right: 36.w,
                bottom: 56.h,
              ),

              ...List<Widget>.generate(PricingPlans.values.length, (index) {
                final plan = PricingPlans.values.elementAt(index);
                final isLast = PricingPlans.values.length == index - 1;

                return PerkCard(plan: plan).pOnly(
                    left: 30.w, right: 30.w, bottom: isLast ? 32.h : 24.h);
              }),

              LabelButton(
                label:
                    'Please note that School admins are required to purchase a plan at the next stage ',
                actionText: "Learn More",
                onTap: () {
                  log.i('Proceed to learn more');
                },
              ).pSymmetric(),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.midnightBlue,
                ),
            children: const [
              TextSpan(
                text: "Welcome to ",
              ),
              TextSpan(
                  text: "Scoolspace, ",
                  style: TextStyle(color: AppColors.skyBlue)),
              TextSpan(text: "Scool"),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          "Please select the option that best describe you",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

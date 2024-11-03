import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/utils/enums/pricing_plans.dart';
import 'package:schoolspace/utils/extensions/widget_extensions.dart';


class PerkCard extends StatelessWidget {
  const PerkCard({
    super.key,
    required this.plan,
  });

  final PricingPlans plan;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: 27.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: plan.color,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: PerkText(plan: plan).pOnly(right: 108.w),
        ),
        Positioned.fill(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  plan.imgPath,
                  fit: BoxFit.cover,
                ))),
        Positioned.fill(
            child: PerkText(plan: plan).pOnly(right: 120.w, left: 16.w, top: 27.h, bottom: 27.h))
      ],
    );
  }
}

class PerkText extends StatelessWidget {
  const PerkText({
    super.key,
    required this.plan,
  });

  final PricingPlans plan;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          plan.describe,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700, color: AppColors.surfaceColor),
        ),
        Text(
          plan.subtitle,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.surfaceColor,
              ),
        ),
      ],
    );
  }
}

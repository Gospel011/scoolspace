import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class AppTypography {
  static final defaultTextTheme = TextStyle(
    color: AppColors.midnightTeal,
    fontFamily: 'PlusJakartaSans',
    fontSize: 16.sp,
    height: 24.h / 16.sp,
    fontWeight: FontWeight.w400,
  );

  static final displayLarge = TextStyle(
    color: AppColors.midnightTeal,
    fontSize: 64.sp,
    height: 60.48.h / 64.sp,
    fontFamily: 'PlusJakartaSans',
    fontWeight: FontWeight.w400,
  );

  static final displayMedium = TextStyle(
    color: AppColors.midnightTeal,
    fontFamily: 'PlusJakartaSans',
    fontSize: 60.sp,
    height: 84.h / 60.sp,
    fontWeight: FontWeight.w400,
  );

  //*
  static final displaySmall = TextStyle( 
    color: AppColors.midnightTeal,
    fontFamily: 'PlusJakartaSans',
    fontSize: 32.sp,
    height: 40.32.h / 32.sp,
    fontWeight: FontWeight.w400,
  );

  //*
  static final headlineLarge = TextStyle( 
    color: AppColors.midnightTeal,
    fontFamily: 'PlusJakartaSans',
    fontSize: 28.sp,
    height: 35.28.h / 28.sp,
    fontWeight: FontWeight.w400,
  );

  //*
  static final headlineMedium = TextStyle(
    color: AppColors.midnightTeal,
    fontFamily: 'PlusJakartaSans',
    fontSize: 24.sp,
    height: 30.24.h / 24.sp,
    fontWeight: FontWeight.w400,
  );

  static final titleLarge = TextStyle(
    color: AppColors.midnightTeal,
    fontFamily: 'PlusJakartaSans',
    fontSize: 20.sp,
    height: 25.2.h / 20.sp,
    fontWeight: FontWeight.w400,
  );

  static final bodyMedium2 = TextStyle(
    color: AppColors.midnightTeal,
    fontFamily: 'PlusJakartaSans',
    fontSize: 16.sp,
    height: 20.16.h / 16.sp,
    fontWeight: FontWeight.w400,
  );

  //*
  static final bodyMedium = TextStyle(
    color: AppColors.midnightTeal,
    fontFamily: 'PlusJakartaSans',
    fontSize: 14.sp,
    height: 17.64.h / 14.sp,
    fontWeight: FontWeight.w400,
  );

  //*
  static final bodySmall = TextStyle(
    color: AppColors.midnightTeal,
    fontFamily: 'PlusJakartaSans',
    fontSize: 12.sp,
    height: 15.12.h / 12.sp,
    fontWeight: FontWeight.w400,
  );

  //*
  static final labelLarge = TextStyle(
    color: AppColors.midnightTeal,
    fontFamily: 'PlusJakartaSans',
    fontSize: 10.sp,
    height: 16.h / 10.sp,
    fontWeight: FontWeight.w400,
  );


  static final labelSmall = TextStyle(
    color: AppColors.midnightTeal,
    fontFamily: 'PlusJakartaSans',
    fontSize: 8.sp,
    height: 10.08.h / 8.sp,
    fontWeight: FontWeight.w400,
  );
}
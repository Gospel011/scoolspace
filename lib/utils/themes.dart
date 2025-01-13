//* THEMES
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/constants/typography.dart';

class AppThemes {
  // static final defaultTextTheme = GoogleFonts.inter(
  //     textStyle: TextStyle(
  //         color: AppColors.smokyGrape,
  //         fontSize: 16.sp,
  //         height: 24.h / 16.sp,
  //         fontWeight: FontWeight.w400));

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.skyBlue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.skyBlue,
      surface: AppColors.surfaceColor,
      onSurface: AppColors.midnightBlue,
      onSecondaryContainer: AppColors.charcoal,
    ),
    useMaterial3: false,

    //* My text themes
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      headlineLarge: AppTypography.headlineLarge,
      headlineMedium: AppTypography.headlineMedium,
      titleLarge: AppTypography.titleLarge,
      titleSmall: AppTypography.bodyMedium2,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelLarge: AppTypography.labelLarge,
      labelSmall: AppTypography.labelSmall,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.charcoal,
      thickness: 0.5,
    ),

    //*My list tile theme

    listTileTheme: ListTileThemeData(
      titleAlignment: ListTileTitleAlignment.top,
      minVerticalPadding: 10.h,
    ),

    //* My button themes
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(1.0),
            minimumSize: WidgetStatePropertyAll(Size(0, 44.h)),
            padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 22.w, vertical: 14.h)),
            backgroundColor:
                WidgetStateProperty.resolveWith((Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColors.lightGrey;
              }

              return AppColors.skyBlue;
            }),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r))),
            textStyle: WidgetStatePropertyAll(TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                height: 17.64.h / 14.sp)))),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            textStyle: WidgetStatePropertyAll(TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
                height: 22.5.h / 15.sp)))),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 48.h)),
      side: const WidgetStatePropertyAll(BorderSide(color: Colors.transparent)),
    )),

    //* Scaffold theme
    scaffoldBackgroundColor: AppColors.surfaceColor,
    // checkboxTheme: CheckboxThemeData(
    //     fillColor: const WidgetStatePropertyAll(AppColors.royalPurple),
    //     shape:
    //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.r))),

    //* My app bar theme
    appBarTheme: AppBarTheme(
        elevation: 0,
        toolbarHeight: 54.h,
        backgroundColor: AppColors.surfaceColor,
        // shadowColor: AppColors.lavenderGrey,
        iconTheme:
            IconThemeData(size: 24.r, weight: 1, color: AppColors.midnightBlue),
        titleTextStyle: TextStyle(
            color: AppColors.midnightBlue,
            fontFamily: 'PlusJakartaSans',
            fontSize: 17.sp,
            height: 27.h / 17.sp),
        centerTitle: true),

    //* Input slider theme
    // sliderTheme: SliderThemeData(
    //     minThumbSeparation: 0,
    //     trackHeight: 0.2.h,
    //     activeTrackColor: AppColors.royalPurple,
    //     thumbColor: AppColors.royalPurple,
    //     overlayColor: AppColors.royalPurple.withOpacity(0.2),
    //     inactiveTrackColor: AppColors.lavenderMist),

    //* Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      //* padding
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 19.h),

      //* for normal border
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.midnightTeal.withValues(alpha: 0.4),
          ),
          borderRadius: BorderRadius.circular(8.r)),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.red.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.red.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      //* for focused border
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: AppColors.midnightTeal.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(8.r),
      ),

      //* for enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.midnightTeal.withValues(alpha: 0.4),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
    ),
  );
}

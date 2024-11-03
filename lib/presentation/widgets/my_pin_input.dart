import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/utils/constants.dart';

class MyPinInput extends StatelessWidget {
  const MyPinInput({
    super.key,
    required this.controller,
    this.size,
    this.length = 4,
    this.obscureText = true,
    this.onChanged,
  });
  final double? size;
  final int length;
  final bool obscureText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: size ?? 70.r,
      height: size ?? 70.r,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.charcoal.withOpacity(0.1),
        border: Border.all(color: AppColors.midnightTeal.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.midnightTeal.withOpacity(0.5)),
      // borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
          // color: const Color.fromRGBO(234, 239, 243, 1),
          ),
    );

    return Pinput(
      controller: controller,
      onChanged: onChanged,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      length: length,
      obscureText: obscureText,
      separatorBuilder: (_) {
        final screenWidth = MediaQuery.sizeOf(context).width;

        final separatorWidth = (screenWidth -
                2 * AppConstants.defaultPadding -
                (size ?? 70.r) * length) /
            (length - 1);

        // print("_______________________");
        // print("screen width: $screenWidth");
        // print("default padding: ${AppConstants.defaultPadding}");
        // print("size: ${size ?? 70.r}");
        // print("length: $length");
        // print("Separator width: $separatorWidth");

        return SizedBox(
          width: separatorWidth < 0 ? 8 : separatorWidth,
        );
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.disabled,
      showCursor: true,
    );
  }
}

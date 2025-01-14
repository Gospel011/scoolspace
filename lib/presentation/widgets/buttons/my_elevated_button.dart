// import 'package:app/presentation/widgets/my_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyElevatedButton extends StatelessWidget {
  final String text;
  final bool? loading;
  final MainAxisSize mainAxisSize;
  final void Function()? onPressed;
  final IconData? icon;
  final dynamic leadingIcon;
  final Color? backgroundColor;
  final FontWeight? fontWeight;
  final BorderRadiusGeometry? borderRadius;
  final bool disabled;

  const MyElevatedButton({
    super.key,
    this.onPressed,
    this.mainAxisSize = MainAxisSize.max,
    this.borderRadius,
    required this.text,
    this.icon,
    this.fontWeight = FontWeight.bold,
    this.loading,
    this.backgroundColor,
    this.disabled = false,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(16.r),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(16.r))),
              backgroundColor: WidgetStatePropertyAll(backgroundColor)),
          onPressed: disabled
              ? null
              : () {
                  if (onPressed == null) return;
                  loading == true ? null : onPressed!();
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: mainAxisSize,
            children: [
              if (leadingIcon != null)
                leadingIcon is Widget
                    ? leadingIcon
                    : SvgPicture.asset(leadingIcon!)
              else
                const SizedBox(
                  width: 0,
                ),
              if (leadingIcon != null)
                SizedBox(
                  width: 10.w,
                )
              else
                const SizedBox(
                  width: 0,
                ),
              loading != true
                  ? Text(
                      text,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: disabled
                                ? Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer
                                : Theme.of(context).colorScheme.surface,
                            fontSize: disabled ? 14.sp : null,
                            height: disabled ? 17.64.h / 14.sp : null,
                            fontWeight: disabled ? FontWeight.w500 : fontWeight,
                          ),
                    )
                  : const Center(
                      // height: 24,
                      // width: 24,
                      child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
              if (icon != null)
                Icon(icon)
              else
                const SizedBox(
                  width: 0,
                ),
            ],
          )),
    );
  }
}

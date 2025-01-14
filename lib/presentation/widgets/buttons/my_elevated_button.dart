// import 'package:app/presentation/widgets/my_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyElevatedButton extends StatefulWidget {
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
  final GlobalKey? leadingIconKey;

  const MyElevatedButton({
    super.key,
    this.leadingIconKey,
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
  State<MyElevatedButton> createState() => _MyElevatedButtonState();
}

class _MyElevatedButtonState extends State<MyElevatedButton> {
  Size? iconSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(16.r),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius:
                      widget.borderRadius ?? BorderRadius.circular(16.r))),
              backgroundColor: WidgetStatePropertyAll(widget.backgroundColor)),
          onPressed: widget.disabled
              ? null
              : () {
                  if (widget.onPressed == null) return;
                  widget.loading == true ? null : widget.onPressed!();
                },
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: mainAxisSize,
            children: [
              if (widget.leadingIcon != null)
                widget.leadingIcon is Widget
                    ? widget.leadingIcon
                    : SvgPicture.asset(
                        key: widget.leadingIconKey, widget.leadingIcon!),
              Row(
                mainAxisSize: widget.mainAxisSize,
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.leadingIcon != null &&
                      widget.mainAxisSize == MainAxisSize.min)
                    Builder(builder: (context) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final renderBox = widget.leadingIconKey?.currentContext!
                            .findRenderObject() as RenderBox;
                        setState(() {
                          iconSize = renderBox.size;
                        });
                      });

                      return SizedBox(
                        width: (iconSize?.width ?? 0) + 10.w,
                      );
                    }),
                  widget.loading != true
                      ? Text(
                          widget.text,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: widget.disabled
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer
                                    : Theme.of(context).colorScheme.surface,
                                fontSize: widget.disabled ? 14.sp : null,
                                height:
                                    widget.disabled ? 17.64.h / 14.sp : null,
                                fontWeight: widget.disabled
                                    ? FontWeight.w500
                                    : widget.fontWeight,
                              ),
                        )
                      : const Center(
                          // height: 24,
                          // width: 24,
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                  if (widget.icon != null)
                    Icon(widget.icon)
                  else
                    const SizedBox(
                      width: 0,
                    ),
                ],
              )
            ],
          )),
    );
  }
}

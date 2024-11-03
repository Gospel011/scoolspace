import 'package:flutter/material.dart';
import 'package:schoolspace/constants/colors.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    required this.text,
    this.onTap,
    this.textStyle,
  });

  final void Function()? onTap;
  final TextStyle? textStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(
              color: AppColors.skyBlue,
              fontWeight: FontWeight.bold,
            )
            .merge(textStyle),
      ),
    );
  }
}

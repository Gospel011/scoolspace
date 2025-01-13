import 'package:flutter/material.dart';

class SectionText extends StatelessWidget {
  const SectionText(this.text,
      {super.key, this.fontWeight, this.textAlign, this.fontSize, this.height});

  final FontWeight? fontWeight;
  final double? fontSize;
  final double? height;
  final TextAlign? textAlign;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight ?? FontWeight.w500,
            height: height,
          ),
    );
  }
}

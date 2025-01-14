import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key, this.style, this.highlightStyle});

  final TextStyle? style;
  final TextStyle? highlightStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: Theme.of(context).textTheme.labelLarge?.merge(style),
        children: [
          const TextSpan(text: "By continuing, you agree to our "),
          TextSpan(
            text: "Terms of Service ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ).merge(highlightStyle),
          ),
          const TextSpan(text: "and "),
          TextSpan(
            text: "Privacy Policy.",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ).merge(highlightStyle),
          ),
        ],
      ),
    );
  }
}

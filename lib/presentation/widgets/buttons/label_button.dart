import 'package:flutter/material.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/presentation/widgets/buttons/my_text_button.dart';
import 'package:schoolspace/utils/helpers/logger.dart';

class LabelButton extends StatelessWidget {
  const LabelButton({
    super.key,
    required this.actionText,
    required this.label,
    this.onTap,
  });

  final String actionText;
  final String label;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelLarge,
        children: [
          TextSpan(text: label),
          WidgetSpan(
              child: MyTextButton(
            text: actionText,
            onTap: onTap,
            textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.skyBlue, fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }
}

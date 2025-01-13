import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/presentation/widgets/section_text.dart';
import 'package:schoolspace/utils/enums/enums.dart';

class MyTextFormField extends StatelessWidget {
  /// This is used to access the user's input
  final TextEditingController controller;

  /// A function that accepts a nullable string. Used to validate the input
  /// before further action is taked
  final String? Function(String?) validator;

  /// This tells the user what to input in the TextFormField
  final String? hintText;

  /// This is the [widget] that would be shown at the far right of the
  /// TextFormField
  final Widget? suffixIcon;

  /// This is the function that is executed when the [suffixIcon] is pressed.
  final void Function()? suffixOnpressed;

  /// This specifies whether to hide the text or not.
  final bool obscureText;

  /// This specifies whether the user is allowed to input text in the
  /// TextFormField.
  final bool? enabled;

  /// This specifies whether the textfield is editable or not. It stil
  /// uses the enabled text theme, unlike when enabled is set to false.
  final bool? readOnly;

  /// This specifies which type of keyboard should be shown to the user
  final TextInputType? keyboardType;

  /// This controls whether the textform field should be in focus or not
  final FocusNode? focusNode;

  /// What happens when the textform field value is changed
  final void Function(String)? onChanged;

  /// The textfield type
  final TextFieldType? textFieldType;

  /// The action to execute when this textfield is tapped
  final void Function()? onTap;

  /// This filters the users input and accepts only the valid ones.
  final List<TextInputFormatter>? inputFormatters;

  /// The maximum lines the text in this can cover
  final int? maxLines;

  /// The spacing between the edges and the content of this
  final EdgeInsetsGeometry? contentPadding;

  /// An additional descriptive text that would be displayed above the formfield.
  final String? sectionText;

  /// An additional descriptive text that would be displayed above the formfield.
  final FontWeight? sectionTextFontWeight;

  /// The padding for the entire widget
  final EdgeInsetsGeometry? padding;

  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final int? minLines;
  final String? prefixText;
  final String? suffixText;
  final VoidCallback? onSuffixTextPressed;
  final bool? filled;
  final Color? fillColor;

  const MyTextFormField({
    super.key,
    this.hintText,
    this.onTap,
    required this.controller,
    required this.validator,
    this.onSuffixTextPressed,
    this.prefixText,
    this.suffixText,
    this.minLines,
    this.padding,
    this.sectionText,
    this.sectionTextFontWeight,
    this.maxLines,
    this.contentPadding,
    this.suffixIcon,
    this.suffixOnpressed,
    this.obscureText = false,
    this.readOnly,
    this.enabled,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
    this.onChanged,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.textFieldType,
    this.filled,
    this.fillColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionText != null)
            SectionText(
              sectionText!,
              fontWeight: sectionTextFontWeight,
            ),
          if (sectionText != null)
            SizedBox(
              height: 4.h,
            ),
          Stack(
            alignment: Alignment.center,
            children: [
              TextFormField(
                obscureText: obscureText,
                enabled: enabled,
                readOnly: readOnly ?? false,
                maxLines: obscureText == false ? (maxLines ?? 1) : 1,
                minLines: minLines,
                onTap: onTap,
                focusNode: focusNode,
                onChanged: onChanged,
                controller: controller,
                validator: validator,
                cursorColor: AppColors.midnightBlue,
                textAlign: textFieldType == TextFieldType.otp
                    ? TextAlign.center
                    : TextAlign.start,
                keyboardType: textFieldType == TextFieldType.otp
                    ? TextInputType.number
                    : keyboardType,
                cursorWidth: 1.0,
                decoration: InputDecoration(
                    filled: filled,
                    fillColor:
                        fillColor,
                    suffix: suffixText == null
                        ? null
                        : GestureDetector(
                            onTap: onSuffixTextPressed,
                            child: Text(
                              suffixText!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.charcoal,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                    contentPadding: textFieldType == TextFieldType.otp
                        ? const EdgeInsets.symmetric(horizontal: 8)
                        : textFieldType == TextFieldType.password
                            ? EdgeInsets.only(left: 16.w, right: 16.w)
                            : contentPadding,
                    hintText: hintText,
                    // hintStyle: const TextStyle(),
                    prefixText: prefixText,
                    suffixIcon: suffixIcon != null
                        ? IconButton(
                            onPressed: suffixOnpressed, icon: suffixIcon!)
                        : null,
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    errorBorder: errorBorder,
                    focusedErrorBorder: errorBorder),
                inputFormatters: textFieldType == TextFieldType.otp
                    ? [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly
                      ]
                    : inputFormatters,
              ),
              // if (suffixText != null)
              //   Positioned(
              //     right: 12.w,
              //     child: GestureDetector(
              //       onTap: onSuffixTextPressed,
              //       child: Text(
              //         suffixText!,
              //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //               color: AppColors.charcoal,
              //               fontWeight: FontWeight.w500,
              //             ),
              //       ),
              //     ),
              //   )
            ],
          ),
        ],
      ),
    );
  }
}

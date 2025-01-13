import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/presentation/widgets/my_textformfield.dart';
import 'package:schoolspace/presentation/widgets/section_text.dart';
import 'package:schoolspace/utils/constants/countries.dart';
import 'package:schoolspace/utils/extensions/widget_extensions.dart';
import 'package:schoolspace/utils/helpers/logger.dart';
import 'package:schoolspace/utils/validators/validators.dart';

class SignupUserInfo extends StatefulWidget {
  const SignupUserInfo({super.key});

  @override
  State<SignupUserInfo> createState() => _SignupUserInfoState();
}

class _SignupUserInfoState extends State<SignupUserInfo> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController gender = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();

  final TextEditingController streetName = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController stateOrProvince = TextEditingController();
  final TextEditingController country = TextEditingController();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Country dropDownValue = countries.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 22.h,
            ),

            Text(
              'Let\'s get to know you',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ).pOnly(bottom: 8.h, left: 16.w, right: 16.w),

            Text(
              'Fields marked as * are necessary to continue',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ).pOnly(bottom: 20.h, left: 16.w, right: 16.w),

            //

            MultiTextFormField(
              sectionText: 'Name *',
              controllers: [firstName, lastName],
              hintTexts: const ['First name', 'Last name'],
            ).pSymmetric(horizontal: 16.w),

            SizedBox(
              height: 8.h,
            ),

            Text(
              'Please use the name on your birth certificate or school ID',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ).pSymmetric(),

            SizedBox(
              height: 24.h,
            ),

            const SectionText('Phone number').pSymmetric(),

            SizedBox(
              height: 4.h,
            ),

            Row(
              spacing: 8.w,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.blueGrey.withValues(alpha: 0.1)),
                  child: DropdownButton(
                    value: dropDownValue,
                    alignment: Alignment.center,
                    selectedItemBuilder: (context) {
                      return [
                        Center(
                          child: Text(
                            dropDownValue.flag,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        )
                      ];
                    },
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 17.w),
                    borderRadius: BorderRadius.circular(16.r),
                    focusColor: Colors.green,
                    items: List<DropdownMenuItem<Country>>.generate(
                        countries.length, (index) {
                      final Country currentCountry = countries.elementAt(index);
                      return DropdownMenuItem(
                        value: currentCountry,
                        child: RichText(
                            text: TextSpan(
                                text: currentCountry.code,
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                              TextSpan(
                                  text: ' ${currentCountry.flag}',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge)
                            ])),
                      );
                    }),
                    onChanged: (value) {
                      log.i("Clicked value is $value");

                      if (value == null) return;

                      // setState(() {
                      //   dropDownValue = value;
                      // });
                    },
                  ),
                ),
                Expanded(
                  child: MyTextFormField(
                    controller: phoneNumber,
                    validator: signupPhoneNumberValidator,
                  ),
                )
              ],
            ).pSymmetric()
          ],
        ),
      ),
    );
  }
}

class MultiTextFormField extends StatelessWidget {
  const MultiTextFormField(
      {super.key,
      required this.controllers,
      required this.hintTexts,
      this.sectionText,
      this.sectionTextFontWeight});

  final List<TextEditingController> controllers;
  final List<String> hintTexts;

  /// An additional descriptive text that would be displayed above the formfield.
  final String? sectionText;

  final FontWeight? sectionTextFontWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
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

        // text fields
        ...List<Widget>.generate(controllers.length, (index) {
          final int lastIndex = controllers.length - 1;
          final controller = controllers.elementAt(index);
          final hintText = hintTexts.elementAt(index);

          return MyTextFormField(
            controller: controller,
            hintText: hintText,
            // contentPadding: EdgeInsets.zero,
            enabledBorder: OutlineInputBorder(
              borderSide: Theme.of(context)
                  .inputDecorationTheme
                  .enabledBorder!
                  .borderSide,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(index == 0 ? 16.r : 0),
                topRight: Radius.circular(index == 0 ? 16.r : 0),
                bottomRight: Radius.circular(index == lastIndex ? 16.r : 0),
                bottomLeft: Radius.circular(index == lastIndex ? 16.r : 0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: Theme.of(context)
                  .inputDecorationTheme
                  .focusedBorder!
                  .borderSide,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(index == 0 ? 16.r : 0),
                topRight: Radius.circular(index == 0 ? 16.r : 0),
                bottomRight: Radius.circular(index == lastIndex ? 16.r : 0),
                bottomLeft: Radius.circular(index == lastIndex ? 16.r : 0),
              ),
            ),
            validator: (value) {
              return null;
            },
          );
        })
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/presentation/widgets/buttons/my_elevated_button.dart';
import 'package:schoolspace/presentation/widgets/my_textformfield.dart';
import 'package:schoolspace/presentation/widgets/section_text.dart';
import 'package:schoolspace/utils/constants/countries.dart';
import 'package:schoolspace/utils/enums/app_routes.dart';
import 'package:schoolspace/utils/enums/enums.dart';
import 'package:schoolspace/utils/extensions/widget_extensions.dart';
import 'package:schoolspace/utils/helpers/logger.dart';
import 'package:schoolspace/utils/mixins/ui_info_mixin.dart';
import 'package:schoolspace/utils/validators/validators.dart';

class SignupUserInfo extends StatefulWidget {
  const SignupUserInfo({super.key});

  @override
  State<SignupUserInfo> createState() => _SignupUserInfoState();
}

class _SignupUserInfoState extends State<SignupUserInfo> with UiInfoMixin {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();

  Gender? gender;
  DateTime? dateOfBirth;
  bool obscureText = true;
  bool dontRecieveEmails = true;

  final TextEditingController streetName = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController stateOrProvince = TextEditingController();
  final TextEditingController country = TextEditingController();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Country selectedCountry = countries.elementAt(158);
  final formKey = GlobalKey<FormState>();

  bool canValidateAddress = false;
  bool canValidateName = false;

  final GlobalKey nameKey = GlobalKey();
  final GlobalKey phoneKey = GlobalKey();
  final GlobalKey genderKey = GlobalKey();
  final GlobalKey dateOfBirthKey = GlobalKey();
  final GlobalKey addressKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                key: nameKey,
                sectionText: 'Name *',
                canValidate: canValidateName,
                controllers: [firstName, lastName],
                validators: List.generate(
                    2,
                    (index) => (String? value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        }),
                errorTexts: ['First name', 'Last name']
                    .map((el) => '$el can\'t be empty')
                    .toList(),
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
                key: phoneKey,
                spacing: 8.w,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CountryDropDown(
                    value: selectedCountry,
                    onChanged: (value) {
                      log.i("Clicked value is $value");

                      if (value == null || value is! Country) return;

                      selectedCountry = value;
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: MyTextFormField(
                      controller: phoneNumber,
                      hintText: 'Enter your phone number',
                      validator: (value) =>
                          signupPhoneNumberValidator(value, selectedCountry),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  )
                ],
              ).pSymmetric(),

              SizedBox(
                height: 24.h,
              ),

              const SectionText('Gender *').pSymmetric(),
              SizedBox(
                height: 4.h,
              ),

              DropdownButtonFormField(
                key: genderKey,
                borderRadius: BorderRadius.circular(8.r),
                validator: (value) {
                  if (value == null) return 'Select your gender';
                  return null;
                },
                // padding:
                //     EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                value: gender,
                isExpanded: true,
                hint: const Text('Select'),
                items: List<DropdownMenuItem<Gender>>.generate(
                    Gender.values.length, (index) {
                  final currentGender = Gender.values.elementAt(index);
                  return DropdownMenuItem(
                    value: currentGender,
                    child: Text(currentGender.describe),
                  );
                }),
                onChanged: (value) {
                  // if (value != null) {
                  log.i("GENDER VALUE: $value");
                  setState(() {
                    gender = value;
                  });
                  // }
                },
              ).pSymmetric(),

              SizedBox(
                height: 24.h,
              ),
              const SectionText('Date of birth *').pSymmetric(),
              SizedBox(
                height: 4.h,
              ),

              MyTextFormField(
                  key: dateOfBirthKey,
                  controller: TextEditingController(
                      text: dateOfBirth == null
                          ? null
                          : '${dateOfBirth?.month.toString().padLeft(2, '0')}/${dateOfBirth?.day.toString().padLeft(2, '0')}/${dateOfBirth?.year}'),
                  readOnly: true,
                  hintText: 'Birthday(mm/dd/yy)',
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                  onTap: () async {
                    final firstDate =
                        DateTime.now().add(const Duration(days: -100 * 365));
                    final lastDate = DateTime.now();
                    dateOfBirth = await showMyDatePicker(
                      context,
                      initialDate: dateOfBirth,
                      firstDate: firstDate,
                      lastDate: lastDate,
                    );
                    setState(() {});

                    log.i("PICKED DATE: $dateOfBirth");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Select your date of birth';
                    }
                    return null;
                  }).pSymmetric(),

              SizedBox(
                height: 8.h,
              ),

              Text(
                'Ages under 18 will automatically be registered as students.',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ).pSymmetric(),

              SizedBox(
                height: 24.h,
              ),

              const SectionText('Address *').pSymmetric(),

              SizedBox(
                height: 4.h,
              ),

              MultiTextFormField(
                controllers: [streetName, city, stateOrProvince, country],
                canValidate: canValidateAddress,
                errorTexts: [
                  "Street name",
                  'City',
                  'State or provice',
                  'Country'
                ].map((el) => '$el can\'t be empty.').toList(),
                validators: List.generate(
                    4,
                    (index) => (String? value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        }),
                hintTexts: const [
                  'Street name',
                  'City',
                  'State or province',
                  'Country'
                ],
              ).pSymmetric(),

              SizedBox(
                height: 24.h,
              ),

              MyTextFormField(
                controller: email,
                sectionText: 'Email *',
                validator: emailValidator,
                hintText: 'scoolmail@gmail.com',
              ).pSymmetric(),

              SizedBox(
                height: 24.h,
              ),

              MyTextFormField(
                controller: password,
                sectionText: 'Password *',
                suffixText: obscureText ? "Show" : "Hide",
                obscureText: obscureText,
                onSuffixTextPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                validator: passwordValidator,
                hintText: 'Enter your password',
              ).pSymmetric(),

              SizedBox(
                height: 4.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      log.i('implement forgot password');
                    },
                    child: Text(
                      'Forgot password?',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ).pSymmetric(),

              SizedBox(
                height: 32.h,
              ),

              MyElevatedButton(
                text: 'Continue',
                fontWeight: FontWeight.bold,
                onPressed: () {
                  final bool isValid =
                      formKey.currentState?.validate() ?? false;

                  canValidateAddress = true;
                  canValidateName = true;

                  setState(() {});
                  log.i("Valid form? $isValid");

                  const scrollDuration = Duration(milliseconds: 500);
                  const curve = Curves.fastEaseInToSlowEaseOut;
                  const alignment = 0.1;

                  final parsedPhoneNumber =
                      int.tryParse(phoneNumber.text.trim()).toString();

                  if (!isValid) {
                    if (firstName.text.isEmpty || lastName.text.isEmpty) {
                      Scrollable.ensureVisible(
                        nameKey.currentContext!,
                        duration: scrollDuration,
                        curve: curve,
                        alignment: alignment,
                      );
                    } else if (parsedPhoneNumber.length <
                            selectedCountry.minLength ||
                        parsedPhoneNumber.length > selectedCountry.maxLength) {
                      Scrollable.ensureVisible(
                        phoneKey.currentContext!,
                        duration: scrollDuration,
                        curve: curve,
                        alignment: alignment,
                      );
                    } else if (gender == null) {
                      Scrollable.ensureVisible(
                        genderKey.currentContext!,
                        duration: scrollDuration,
                        curve: curve,
                        alignment: alignment,
                      );
                    } else if (dateOfBirth == null) {
                      Scrollable.ensureVisible(
                        dateOfBirthKey.currentContext!,
                        duration: scrollDuration,
                        curve: curve,
                        alignment: alignment,
                      );
                    } else {
                      Scrollable.ensureVisible(
                        addressKey.currentContext!,
                        duration: scrollDuration,
                        curve: curve,
                        alignment: alignment,
                      );
                    }

                    return;
                  }

                  final body = {
                    'firstName': firstName.text.trim(),
                    'lastName': lastName.text.trim(),
                    'phoneNumber':
                        '+${selectedCountry.dialCode}$parsedPhoneNumber',
                    'gender': gender?.name,
                    'dateOfBirth': dateOfBirth?.toIso8601String(),
                    'address': {
                      'streetName': streetName.text.trim(),
                      'city': city.text.trim(),
                      'stateOrProvice': stateOrProvince.text.trim(),
                      'country': country.text.trim()
                    },
                    'email': email.text.trim().toLowerCase(),
                    'password': password.text,
                    'dontRecieveEmails': dontRecieveEmails
                  };

                  log.i("BODY: $body");

                  context.goNamed(AppRoutes.home.name);
                },
              ).pSymmetric(),

              SizedBox(
                height: 24.h,
              ),

              Text(
                "Scoolspace will send you members-only deals, information, marketing emails, and push notifications. You can choose to stop receiving these at any time in your account settings.",
                style: Theme.of(context).textTheme.labelLarge,
              ).pSymmetric(),

              SizedBox(
                height: 16.h,
              ),

              Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: CheckboxListTile(
                  value: dontRecieveEmails,
                  checkboxScaleFactor: 1.5,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: RichText(
                      text: TextSpan(
                          text:
                              "I don't want to receive marketing messages from ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                          children: [
                        TextSpan(
                          text: ' Scoolspace',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      ])),
                  onChanged: (value) {
                    log.i("New value is: $value");

                    if (value == null) return;

                    setState(() {
                      dontRecieveEmails = value;
                    });
                  },
                ).pSymmetric(horizontal: 8.w),
              ),

              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryDropDown extends StatelessWidget {
  const CountryDropDown({super.key, required this.value, this.onChanged});

  final dynamic value;
  final void Function(Object?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColors.blueGrey.withValues(alpha: 0.1)),
      child: DropdownButton(
        value: value,
        alignment: Alignment.center,
        selectedItemBuilder: (context) {
          return List<Widget>.generate(countries.length, (index) {
            return Center(
              child: Text(
                countries.elementAt(index).flag,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            );
          });
        },
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 17.w),
        borderRadius: BorderRadius.circular(16.r),
        focusColor: Colors.green,
        items:
            List<DropdownMenuItem<Country>>.generate(countries.length, (index) {
          final Country currentCountry = countries.elementAt(index);
          return DropdownMenuItem(
            value: currentCountry,
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: currentCountry.code,
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                          text: ' ${currentCountry.flag}',
                          style: Theme.of(context).textTheme.headlineLarge)
                    ])),
          );
        }),
        onChanged: onChanged,
      ),
    );
  }
}

class MultiTextFormField extends StatelessWidget {
  const MultiTextFormField({
    super.key,
    required this.controllers,
    required this.hintTexts,
    this.sectionText,
    this.validators,
    this.sectionTextFontWeight,
    this.errorTexts,
    this.canValidate = false,
  });

  final List<TextEditingController> controllers;
  final List<String> hintTexts;
  final List<String>? errorTexts;
  final bool canValidate;

  /// An additional descriptive text that would be displayed above the formfield.
  final String? sectionText;

  final FontWeight? sectionTextFontWeight;

  final List<String? Function(String? value)>? validators;

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
            errorStyle: TextStyle(height: -100.h),
            validator: validators != null
                ? validators!.elementAt(index)
                : (value) => null,
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
            errorBorder: OutlineInputBorder(
              borderSide: Theme.of(context)
                  .inputDecorationTheme
                  .errorBorder!
                  .borderSide,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(index == 0 ? 16.r : 0),
                topRight: Radius.circular(index == 0 ? 16.r : 0),
                bottomRight: Radius.circular(index == lastIndex ? 16.r : 0),
                bottomLeft: Radius.circular(index == lastIndex ? 16.r : 0),
              ),
            ),
          );
        }),

        Builder(
          builder: (context) {
            String? errorText;

            if (validators == null || !canValidate) {
              return const SizedBox.shrink();
            }
            int index = 0;

            final List<String?> results = validators?.map((validator) {
                  return validator(controllers.elementAt(index++).text);
                }).toList() ??
                [];

            log.e("Error texts: $results");

            final errorIndex = results.indexWhere((el) => el is String);

            if (errorIndex >= 0) {
              errorText = errorTexts!.elementAt(errorIndex);

              log.i("TEXT: $errorText");
              return Text(
                errorText,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ).pOnly(left: 16.w, right: 16.w, top: 8.h);
            } else {
              return const SizedBox.shrink();
            }
          },
        )
      ],
    );
  }
}

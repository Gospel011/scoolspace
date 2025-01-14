import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/presentation/widgets/buttons/my_elevated_button.dart';
import 'package:schoolspace/presentation/widgets/components/terms_and_conditions.dart';
import 'package:schoolspace/utils/enums/app_routes.dart';
import 'package:schoolspace/utils/extensions/widget_extensions.dart';
import 'package:schoolspace/utils/helpers/logger.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  late List<Widget> pages;
  late List<AnimationController> animationControllers;
  late List<Animation> animations;
  final pageController = PageController();
  int currentPage = 0;

  ColorScheme get colorScheme {
    return Theme.of(context).colorScheme;
  }

  @override
  void initState() {
    super.initState();

    final titles = [
      "a new way to manage\n",
      "a new way to teach",
      "a new way to learn",
      "a new way to learn"
    ];
    final subtitles = ["school processes", null, null, null];
    final labels = [
      "Keep tabs, and records of what goes on in your school",
      "Teach in a new fun and efficient way",
      "Learn in a fun way bruhh",
      "Stay involved, stay connected with the kids in school"
    ];
    final titleColors = [
      AppColors.brightGreen,
      AppColors.energyYellow,
      AppColors.skyBlue,
      AppColors.red
    ];

    pages = List<Widget>.generate(4, (index) {
      return OnboardingPageView(
          asset: 'assets/images/onboarding_0${index + 1}.png',
          title: titles.elementAt(index),
          subtitle: subtitles.elementAt(index),
          label: labels.elementAt(index),
          titleColor: titleColors.elementAt(index));
    });

    pages.add(const FifthOnboardingPageView());

    animationControllers =
        List<AnimationController>.generate(pages.length, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(seconds: 5),
      );
    });

    animations = List<Animation>.generate(animationControllers.length, (index) {
      return Tween<double>(begin: 0, end: 1)
          .animate(animationControllers.elementAt(index));
    });

    // animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _runAnimations();
    });
  }

  Future<void> _runAnimations([int startIndex = 0]) async {
    for (var i = startIndex; i < animationControllers.length; i++) {
      if (pageController.hasClients) {
        pageController.animateToPage(
          i,
          duration: Durations.medium2,
          curve: Curves.easeInOut,
        );
      }
      await animationControllers[i].forward();

      await Future.delayed(Durations.long1);
    }
  }

  void resetAnimations([int startIndex = 0]) {
    // reset animations from current page to the last page
    for (var i = startIndex; i < animationControllers.length; i++) {
      animationControllers.elementAt(i).reset();
    }

    // complete animations from start to the current page
    for (var i = 0; i < startIndex; i++) {
      final controller = animationControllers.elementAt(i);

      if (!controller.isCompleted) {
        controller.forward(from: 1);
      }
    }
  }

  @override
  void dispose() {
    for (var i = 0; i < animationControllers.length; i++) {
      animationControllers.elementAt(i).dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //? background pageview
          PageView.builder(
            controller: pageController,
            itemCount: pages.length,
            onPageChanged: (value) {
              log.i("NEW PAGE: $value");
              resetAnimations(value);
              _runAnimations(value);
            },
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),

          //? page progress indicators
          SafeArea(
            child: Row(
              spacing: 10.w,
              children: [
                ...List<Widget>.generate(pages.length, (index) {
                  return Expanded(
                    child: AnimatedBuilder(
                      animation: animations.elementAt(index),
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          minHeight: 2.h,
                          value: animations.elementAt(index).value,
                          color: Colors.white,
                          backgroundColor: AppColors.softGrey,
                        ).pOnly(top: 20.h);
                      },
                    ),
                  );
                })
              ],
            ).pSymmetric(horizontal: 32.w),
          ),

          //? bottom navigation bar
          Positioned.fill(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //? signup login
              Row(
                spacing: 16.w,
                children: [
                  Expanded(
                    child: MyElevatedButton(
                      text: 'Sign up',
                      onPressed: () {
                        context.goNamed(AppRoutes.getStarted.name);
                      },
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                  ),
                  Expanded(
                    child: MyElevatedButton(
                      text: 'Login',
                      onPressed: () {
                        context.goNamed(AppRoutes.loginEmail.name);
                      },
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 38.h,
              ),

              TermsAndConditions(
                style: TextStyle(color: Theme.of(context).colorScheme.surface),
              ).pSymmetric(horizontal: 30.w)
            ],
          ).pOnly(left: 30.w, right: 30.w, bottom: 34.h))
        ],
      ),
    );
  }
}

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    super.key,
    required this.asset,
    required this.title,
    this.subtitle,
    required this.label,
    required this.titleColor,
  });

  final String asset;
  final String title;
  final String? subtitle;
  final String label;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // filled background image
        Positioned.fill(
          child: Image.asset(
            asset,
            fit: BoxFit.fitHeight,
          ),
        ),

        // color overlay
        Positioned.fill(
            child: Container(
          color: AppColors.midnightBlue.withValues(alpha: 0.6),
        )),

        // text
        Positioned(
          bottom: (285 / 844) * MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: "Introducing\n",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.bold),
                    children: [
                      //? Title
                      TextSpan(
                        text: title,
                        style: TextStyle(
                          color: titleColor,
                        ),
                      ),

                      //? Subtitle
                      if (subtitle != null)
                        TextSpan(
                          text: subtitle,
                          // style: TextStyle(
                          //   color: Theme.of(context).colorScheme.tertiary,
                          // ),
                        )
                    ]),
              ),
              SizedBox(
                height: 8.h,
              ),

              //? Label
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
              )
            ],
          ).pSymmetric(horizontal: 28.w),
        )
      ],
    );
  }
}

class FifthOnboardingPageView extends StatelessWidget {
  const FifthOnboardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
            child: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xFF000B3B),
                Color(0xFF00091A),
              ],
            ),
          ),
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/onboarding_05.png',
                width: 320.r,
                height: 320.r,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: (112 / 844) * MediaQuery.sizeOf(context).height,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "Introducing\n",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.bold,
                      ),
                  children: [
                    TextSpan(
                      text: 'The new school',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ]),
            )
          ],
        ) //.pSymmetric(horizontal: 30.w)
      ],
    );
  }
}

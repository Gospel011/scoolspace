import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:schoolspace/presentation/app_pages/home.dart';
import 'package:schoolspace/presentation/auth_pages/get_started_page.dart';
import 'package:schoolspace/presentation/auth_pages/login/login_email.dart';
import 'package:schoolspace/presentation/auth_pages/login/login_password.dart';
import 'package:schoolspace/presentation/auth_pages/signup/signup_email.dart';
import 'package:schoolspace/presentation/auth_pages/signup/signup_password.dart';
import 'package:schoolspace/presentation/auth_pages/signup/signup_user_info.dart';
import 'package:schoolspace/presentation/auth_pages/signup/signup_verify_email.dart';
import 'package:schoolspace/presentation/onboarding_pages/onboarding.dart';
import 'package:schoolspace/utils/enums/app_routes.dart';
import 'package:schoolspace/utils/helpers/logger.dart';

class AppRouterConfig {
  // static final AuthCubit authCubit = AuthCubit();

  AppRouterConfig();

  // chatCubit = ChatCubit(authCubit);

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  // ServiceCubit uploadServiceCubit;
  // RoommateCubit uploadRoommateCubit;
  // LodgeCubit uploadLodgeCubit;

  // ServiceCubit serviceCubit;
  // RoommateCubit roommateCubit;
  // LodgeCubit lodgeCubit;
  // ChatCubit chatCubit;

  final goRouter = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/${AppRoutes.onboarding.path}',
      routes: [
        //? L O G G E D   I N   R O U T E S
        GoRoute(
            name: AppRoutes.home.name,
            path: "/${AppRoutes.home.path}",
            builder: (context, state) {
              return const Home();
            }),

        //? E M A I L   V E R I F I C  A T I O N
        GoRoute(
            name: AppRoutes.signupVerifyEmail.name,
            path: "/${AppRoutes.signupVerifyEmail.path}",
            builder: (context, state) {
              return const SignupVerifyEmail();
            }),

        //? ONBOARDING
        GoRoute(
            name: AppRoutes.onboarding.name,
            path: "/${AppRoutes.onboarding.path}",
            builder: (context, state) {
              return const Onboarding();
            }),

        //? A U T H E N T I C A T I O N   R O U T E S
        GoRoute(
            name: AppRoutes.loginEmail.name,
            path: "/${AppRoutes.loginEmail.path}",
            builder: (context, state) {
              return const LoginEmail();
            },
            routes: [
              GoRoute(
                name: AppRoutes.loginPassword.name,
                path: AppRoutes.loginPassword.path,
                builder: (context, state) {
                  return const LoginPassword();
                },
              )
            ]),
        GoRoute(
            name: AppRoutes.getStarted.name,
            path: "/${AppRoutes.getStarted.path}",
            builder: (context, state) {
              return const GetStartedPage();
            },
            routes: [
              //SIGNUP EMAIL
              GoRoute(
                name: AppRoutes.signupEmail.name,
                path: AppRoutes.signupEmail.path,
                builder: (context, state) {
                  return const SignupEmail();
                },
              ),
              // SIGNUP PASSWORD
              GoRoute(
                name: AppRoutes.signupPassword.name,
                path: AppRoutes.signupPassword.path,
                builder: (context, state) {
                  return const SignupPassword();
                },
              ),

              // SIGNUP USER INFO
              GoRoute(
                name: AppRoutes.signupUserInfo.name,
                path: AppRoutes.signupUserInfo.path,
                builder: (context, state) {
                  return const SignupUserInfo();
                },
              ),
            ]),
      ],
      redirect: (context, state) {
        // bool isLoggedIn =
        //     authCubit.state.user != null && authCubit.state.token != null;
        bool isLoggedIn = false;
        String currentLocation = state.matchedLocation;

        // log.i("CHECKING AUTH CUBIT: ${authCubit.state}");

        log.i("Current location $currentLocation is logged in $isLoggedIn");

        if (currentLocation == '/signup-email' && isLoggedIn == true) {
          log.i("\n::: \nUser is logged in so redirecting to home\n::: ");
          return '/home'; //? original

          // return '/roommates-page/roommates-filter';
          // return '/home/request-roommate-intro/request-roommate';
        }

        // if (currentLocation.startsWith('/home') && isLoggedIn == false) {
        //   return '/signup-email';
        // }

        return null;
      });

  GoRouter get router {
    return goRouter;
  }
}

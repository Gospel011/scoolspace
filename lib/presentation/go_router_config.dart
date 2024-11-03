import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:schoolspace/presentation/app_pages/home.dart';
import 'package:schoolspace/presentation/auth_pages/signup_email.dart';
import 'package:schoolspace/presentation/auth_pages/signup_password.dart';
import 'package:schoolspace/presentation/auth_pages/signup_verify_email.dart';
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
      initialLocation: '/signup-email',
      routes: [
        //? L O G G E D   I N   R O U T E S
        GoRoute(
            name: AppRoutes.home.name,
            path: "/home",
            builder: (context, state) {
              return const Home();
            }),

        //? E M A I L   V E R I F I C  A T I O N
        GoRoute(
            name: AppRoutes.signupVerifyEmail.name,
            path: "/signup-verify-email",
            builder: (context, state) {
              return const SignupVerifyEmail();
            }),

        //? A U T H E N T I C A T I O N   R O U T E S
        GoRoute(
            name: AppRoutes.signupEmail.name,
            path: "/signup-email",
            builder: (context, state) {
              return const SignupEmail();
            },
            routes: [
              // FORGOT PASSWORD
              GoRoute(
                name: AppRoutes.signupPassword.name,
                path: "signup-password",
                builder: (context, state) {
                  return const SignupPassword();
                },
              ),

              // SIGNUP
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

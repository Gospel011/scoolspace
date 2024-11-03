import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:schoolspace/presentation/auth_pages/signup_email.dart';
import 'package:schoolspace/presentation/go_router_config.dart';
import 'package:schoolspace/utils/themes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final AppRouterConfig routerConfig = AppRouterConfig();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: Builder(builder: (context) {
        return MaterialApp.router(
          title: 'Schoolspace',
          theme: AppThemes.lightTheme,
          routerConfig: routerConfig.router,
        );
      }),
    );
  }
}

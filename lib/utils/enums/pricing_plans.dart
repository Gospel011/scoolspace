import 'dart:ui';

import 'package:schoolspace/constants/colors.dart';
import 'package:schoolspace/utils/extensions/string_extension.dart';

enum PricingPlans {
  student(
    'Organise your school activities',
    'assets/images/student.png',
    AppColors.skyBlue,
  ),
  parent(
    "Get involved in your kid's school activities",
    'assets/images/parent.png',
    Color(0xFFFF3333),
  ),
  teacher(
    "Prepare for your next class",
    'assets/images/teacher.png',
    Color(0xFF662D91),
  ),
  admin(
    "Take charge of all your school activities",
    'assets/images/admin.png',
    Color(0XFF662D91),
  );

  String get describe => name.capitalize;

  final String subtitle;
  final String imgPath;
  final Color color;
  const PricingPlans(this.subtitle, this.imgPath, this.color);
}

import 'package:flutter/material.dart';

mixin UiInfoMixin {
  Future<DateTime?> showMyDatePicker(BuildContext context,
      {DateTime? firstDate, DateTime? lastDate, DateTime? initialDate}) {
    return showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light(useMaterial3: true).copyWith(
              colorScheme: Theme.of(context).colorScheme,
            ),
            child: child!,
          );
        },
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime.now(),
        lastDate: lastDate ?? DateTime.now().add(const Duration(days: 14)));
  }
}

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../../../../core/app_colors.dart';

String dateFoemated(String date) {
  return DateFormat(
    'dd MMM yyyy',
  ).format(DateTime.parse(date.toString()));
}

Future<DateTime?> showDateEPicker(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(20100),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: Colors.white,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          ),
        ),
        child: child!,
      );
    },
  );
  if (pickedDate != null) {
    return pickedDate;
  } else {
    return null;
  }
}

Future<TimeOfDay?> showPicker(BuildContext context) async {
  TimeOfDay? pickedDate = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: Colors.white,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          ),
        ),
        child: child!,
      );
    },
  );
  if (pickedDate != null) {
    return pickedDate;
  } else {
    return null;
  }
}

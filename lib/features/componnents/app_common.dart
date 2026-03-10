import 'dart:math';

import 'package:hr_manegement/data/storage/local/app_prefs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/di.dart';

class AppHelper {
  String getRandom(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';
    Random r = Random();
    return String.fromCharCodes(
      Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  Future<DateTime?> dateTimePicker(
    BuildContext context, {
    TimeOfDay? timeOfday,
  }) async {
    DateTime? date = await pickDate(context);
    if (date == null) return null;

    TimeOfDay? time = await pickTime(context, timeOfday: timeOfday);
    if (time == null) return null;

    DateTime newDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return newDateTime;
  }

  Future<DateTime?> pickDate(BuildContext context) => showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );

  Future<TimeOfDay?> pickTime(BuildContext context, {TimeOfDay? timeOfday}) =>
      showTimePicker(
        context: context,
        initialTime: timeOfday ?? TimeOfDay.now(),
      );

  static String formatDate(String date) {
    if (date == "") return "";
    List<String> parts = date.split('-');
    String formattedDate =
        '${parts[0]}-${parts[1].padLeft(2, '0')}-${parts[2].padLeft(2, '0')}';
    var parsedDate = DateTime.tryParse(formattedDate);
    if (parsedDate == null) return date;
    return DateFormat(
      'dd MMM yy',
      getIt<AppPreferences>().lang,
    ).format(parsedDate).toUpperCase();
  }
}

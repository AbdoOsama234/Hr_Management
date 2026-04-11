import 'dart:developer';

import 'package:hr_manegement/core/constants.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/data/storage/local/app_prefs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:hijri/hijri_calendar.dart';

import '../ sheard/componnents/date_time_widgets/common.dart';
import 'di/di.dart';

void dPrint(String message, {int level = 1, String? tag}) {
  if (kDebugMode) {
    var a = StackTrace.current;
    final regexCodeLine = RegExp(r' (\(.*\))$');
    var i = regexCodeLine
        .stringMatch(a.toString().split('\n')[level])
        .toString()
        .replaceAll('(', "")
        .replaceAll(')', "")
        .trim() /*.split("/")*/;
    var tPrent = '$i\n${tag != null ? '$tag: ' : ''}$message';
    if (message.length > 1800) {
      log(tPrent);
    } else {
      print(tPrent);
    }
  }
}

String getImageUrl(String? url) {
  if (url != null) {
    return url;
  } else {
    return '';
  }
}

String getAppropriateDate(String date) {
  if (date == "-") return "-";
  if (getIt<AppPreferences>().dateMethod == Constants.hijriDate) {
    return convertDateFromGregorianToHijri(date);
  } else {
    return dateFoemated(date.orEmpty());
  }
}

String convertDateFromGregorianToHijri(String date) {
  try {
    // نحاول نكتشف تنسيق التاريخ
    DateTime parsedDate;
    if (date.contains('-')) {
      // لو التاريخ بالشكل yyyy-MM-dd
      parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    } else if (date.contains('/')) {
      // احتمال يكون dd/MM/yyyy
      parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    } else {
      parsedDate = DateFormat('dd-MM-yyyy').parse(date);
    }

    final hijri = HijriCalendar.fromDate(parsedDate);
    return "${hijri.hDay}-${hijri.hMonth}-${hijri.hYear}";
  } catch (e) {
    print("it's date $date");
    print("❌ Error converting date: $e");
    return date;
  }
}

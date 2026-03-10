import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/componnents/show_flutter_snackbar.dart';

class LaunchHelper {
  static callPhoneNumber(String phone) async {
    if (!await launchUrl(Uri.parse('tel:$phone'))) {
      showFlutterSnackBar(
        message: "Something went wrong, try again later".tr(),
        toastColor: Colors.red,
      );
    }
  }

  static openLink(String link) async {
    if (!await launchUrl(Uri.parse(link))) {
      showFlutterSnackBar(
        message: "Something went wrong, try again later".tr(),
        toastColor: Colors.red,
      );
    }
  }

  static Future<void> sendEmail({
    required String email,
    String? subject,
    String? body,
  }) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null && subject.isNotEmpty) 'subject': subject,
        if (body != null && body.isNotEmpty) 'body': body,
      },
    );

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok) {
      showFlutterSnackBar(
        message: "No email app found. Email copied.".tr(),
        toastColor: Colors.red,
      );
    }
  }

  static sendWhatsappNumber({
    required String phone,
    String message = "",
  }) async {
    final whatsappUrl = Uri.parse("https://wa.me/$phone?text=$message");
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      showFlutterSnackBar(
        message: "Something went wrong, try again later".tr(),
        toastColor: Colors.red,
      );
    }
  }

  void launchURLFunction(String website) async {
    try {
      final Uri parsedUri = Uri.parse(website);
      print(parsedUri.toString());
      if (!await launchUrl(parsedUri, mode: LaunchMode.externalApplication)) {
        showFlutterSnackBar(
          message: "Something went wrong, try again later".tr(),
          toastColor: Colors.red,
        );
      }
    } catch (e) {
      showFlutterSnackBar(
        message: "Something went wrong, try again later".tr(),
        toastColor: Colors.red,
      );
      print("launchURLFunction erorr $e");
    }
  }

  static Future<void> openWazeMap({
    required double lat,
    required double lang,
  }) async {
    String wazeUrl = 'waze://?ll=${lat.toString()},${lang.toString()}';

    String fallbackUrl =
        'https://waze.com/ul?ll=${lat.toString()},${lang.toString()}&navigate=yes';
    try {
      if (await canLaunchUrl(Uri.parse(wazeUrl))) {
        await launchUrl(
          Uri.parse(wazeUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        await launchUrl(
          Uri.parse(fallbackUrl),
          mode: LaunchMode.externalApplication,
        );
        showFlutterSnackBar(
          message: "Something went wrong, try again later".tr(),
          toastColor: Colors.red,
        );
      }
    } catch (e) {
      showFlutterSnackBar(
        message: "Something went wrong, try again later".tr(),
        toastColor: Colors.red,
      );
    }
  }

  static Future<void> openGoogle({
    required double lat,
    required double lang,
  }) async {
    final appleMapsUrl = 'http://maps.apple.com/?ll=$lat,$lang';
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lang';

    final Uri url = Uri.parse(Platform.isIOS ? appleMapsUrl : googleMapsUrl);

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        showFlutterSnackBar(
          message: "Something went wrong, try again later".tr(),
          toastColor: Colors.red,
        );
      }
    } catch (e) {
      showFlutterSnackBar(
        message: "Something went wrong, try again later".tr(),
        toastColor: Colors.red,
      );
    }
  }

  static Future<void> openLocationChooser(double lat, double lng) async {
    final uri = Uri.parse('geo:$lat,$lng?q=$lat,$lng');

    final ok = await launchUrl(uri); // no mode
    if (!ok) {
      showFlutterSnackBar(
        message: "Something went wrong, try again later".tr(),
        toastColor: Colors.red,
      );
    }
  }
}

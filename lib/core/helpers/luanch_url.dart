import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ sheard/componnents/show_app_toast.dart';

class LaunchHelper {
  static Future<void> callPhoneNumber(String phone) async {
    if (!await launchUrl(Uri.parse('tel:$phone'))) {
      CustomToast.show(
        message: "Something went wrong, try again later".tr(),
        type: ToastType.error,
      );
    }
  }

  static Future<void> openLink(String link) async {
    if (!await launchUrl(Uri.parse(link))) {
      CustomToast.show(
        message: "Something went wrong, try again later".tr(),
        type: ToastType.error,
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
      CustomToast.show(
        message: "No email app found. Email copied.".tr(),
        type: ToastType.error,
      );
    }
  }

  static Future<void> sendWhatsappNumber({
    required String phone,
    String message = "",
  }) async {
    final whatsappUrl = Uri.parse("https://wa.me/$phone?text=$message");
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      CustomToast.show(
        message: "Something went wrong, try again later".tr(),
        type: ToastType.error,
      );
    }
  }

  void launchURLFunction(String website) async {
    try {
      final Uri parsedUri = Uri.parse(website);
      print(parsedUri.toString());
      if (!await launchUrl(parsedUri, mode: LaunchMode.externalApplication)) {
        CustomToast.show(
          message: "Something went wrong, try again later".tr(),
          type: ToastType.error,
        );
      }
    } catch (e) {
      CustomToast.show(
        message: "Something went wrong, try again later".tr(),
        type: ToastType.error,
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
        CustomToast.show(
          message: "Something went wrong, try again later".tr(),
          type: ToastType.error,
        );
      }
    } catch (e) {
      CustomToast.show(
        message: "Something went wrong, try again later".tr(),
        type: ToastType.error,
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
        CustomToast.show(
          message: "Something went wrong, try again later".tr(),
          type: ToastType.error,
        );
      }
    } catch (e) {
      CustomToast.show(
        message: "Something went wrong, try again later".tr(),
        type: ToastType.error,
      );
    }
  }

  static Future<void> openLocationChooser(double lat, double lng) async {
    final uri = Uri.parse('geo:$lat,$lng?q=$lat,$lng');

    final ok = await launchUrl(uri); // no mode
    if (!ok) {
      CustomToast.show(
        message: "Something went wrong, try again later".tr(),
        type: ToastType.error,
      );
    }
  }
}

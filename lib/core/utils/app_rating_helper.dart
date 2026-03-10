import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class AppRatingHelper {
  // iOS App Store link
  static const String _iosAppStoreUrl =
      'https://apps.apple.com/us/app/aqaraty-%D8%B9%D9%82%D8%A7%D8%B1%D8%A7%D8%AA%D9%8A/id6749689592';

  // Google Play Store link
  static const String _androidPlayStoreUrl =
      'https://play.google.com/store/apps/details?id=com.engaz.aqaraty&pli=1';

  /// Opens the app store rating page based on the current platform
  static Future<void> rateApp() async {
    try {
      String url;
      if (Platform.isIOS) {
        url = _iosAppStoreUrl;
      } else if (Platform.isAndroid) {
        url = _androidPlayStoreUrl;
      } else {
        print('Rating is not supported on this platform');
        return;
      }

      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Error opening app store for rating: $e');
    }
  }
}

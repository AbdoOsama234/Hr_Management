import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class RateAppHelper {
  // iOS App Store link
  static const String _iosAppStoreUrl =
      'https://apps.apple.com/us/app/aqaraty-%D8%B9%D9%82%D8%A7%D8%B1%D8%A7%D8%AA%D9%8A/id6749689592';
  
  // Android Google Play Store link
  static const String _androidPlayStoreUrl =
      'https://play.google.com/store/apps/details?id=com.engaz.aqaraty&pli=1';

  /// Opens the app store rating page based on the device platform
  static Future<void> rateApp() async {
    try {
      String storeUrl;
      
      if (Platform.isIOS) {
        storeUrl = _iosAppStoreUrl;
      } else if (Platform.isAndroid) {
        storeUrl = _androidPlayStoreUrl;
      } else {
        // For other platforms, default to Android link
        storeUrl = _androidPlayStoreUrl;
      }

      final Uri url = Uri.parse(storeUrl);
      
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $storeUrl');
      }
    } catch (e) {
      print('Error opening app store for rating: $e');
    }
  }
}

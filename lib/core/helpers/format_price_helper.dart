import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/di/di.dart';

import '../../data/storage/local/app_prefs.dart';

class FormatPriceHelper {
  static String formatPrice(String? price) {
    double priceValue = double.tryParse(price ?? "0") ?? 0.0;
    var formattedPrice = NumberFormat.currency(
      locale: getIt<AppPreferences>().lang, // You can change the locale
      symbol: '﷼'.tr(), // Currency symbol, adjust as needed
      decimalDigits: 2,
      customPattern: "#,##0.00 ¤",
    ).format(priceValue);
    return formattedPrice;
  }
}

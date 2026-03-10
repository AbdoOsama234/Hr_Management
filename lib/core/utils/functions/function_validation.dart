import 'package:easy_localization/easy_localization.dart';
import 'function_utils.dart';

String? checkPhoneNumberValid(
    {required String? value, required int lengthNumberPhone,required String language}) {
  bool isLanguageEnglish = isEnglish(language);
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number'.tr();
  }
  final isNumeric = RegExp(r'^\d+$').hasMatch(value);

  if (!isNumeric) {
    return 'Phone number must contain digits only'.tr();
  }
  if (value.length != lengthNumberPhone) {
    return isLanguageEnglish
        ? 'Invalid number. It must be $lengthNumberPhone digits long'
        : 'رقم غير صالح، يجب أن يحتوي على $lengthNumberPhone رقمًا ';
  }
  if (!((value[0] == '1' && (value[1] == '1' || value[1] == '2' || value[1] == '0' || value[1] == '5') && lengthNumberPhone == 10) || (value[0] == '5' && lengthNumberPhone == 9))) {
    return "Invalid phone number".tr();
  }
  return null;
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:intl_mobile_field/country_picker_dialog.dart';
import 'package:intl_mobile_field/mobile_number.dart';
import 'package:intl_mobile_field/intl_mobile_field.dart';
import '../../../../core/app_colors.dart';
import 'custom_text_field.dart';

class CodePickerTextFieldTwo extends StatefulWidget {
  const CodePickerTextFieldTwo({
    super.key,
    this.initialCountryCode = "SA",
    required this.controller,
    required this.labelText,
    this.suffixIcon,
    this.onChanged,
    this.onSaved,
    this.readOnly = false,
  });

  final String initialCountryCode;
  final TextEditingController controller;
  final String labelText;
  final IconData? suffixIcon;
  final void Function(MobileNumber phoneNumber)? onChanged;
  final void Function(MobileNumber? phoneNumber)? onSaved;
  final bool readOnly;

  @override
  State<CodePickerTextFieldTwo> createState() => _CodePickerTextFieldTwoState();
}

class _CodePickerTextFieldTwoState extends State<CodePickerTextFieldTwo> {
  //late String _countryCode;

  @override
  void initState() {
    super.initState();
    //_countryCode = widget.initialCountryCode.isNotEmpty ? widget.initialCountryCode : 'EG';
  }

  // @override
  // void didUpdateWidget(covariant CodePickerTextFieldTwo oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.initialCountryCode != oldWidget.initialCountryCode) {
  //     setState(() {
  //       _countryCode = widget.initialCountryCode.isNotEmpty
  //           ? widget.initialCountryCode
  //           : 'EG';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print("✅ initialCountryCode build: ${widget.initialCountryCode}");
    //print("🌍 current countryCode: $_countryCode");

    return IntlMobileField(
      key: ValueKey(
        widget.initialCountryCode,
      ), // ✅ يضمن إعادة البناء بالقيمة الجديدة
      pickerDialogStyle: PickerDialogStyle(
        searchFieldInputDecoration: InputDecoration(
          labelText: "Search country".tr(),
        ),
      ),

      languageCode: context.locale.languageCode == "en" ? "en" : "ar",
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 3.w),
        labelText: widget.labelText,
        // labelStyle: const TextStyle(color: Colors.grey),
        suffixIcon: widget.suffixIcon != null
            ? Icon(widget.suffixIcon, weight: 10, color: AppColors.primary)
            : null,
        labelStyle: TextStyle(
          fontSize: 16,
          color: AppColors.textSub.withOpacity(0.5),
        ),
        hintStyle: TextStyle(
          fontSize: 16,
          color: AppColors.textSub.withOpacity(0.5),
        ),
        enabledBorder: enabledBorder(radius: 10),
        border: border(radius: 10),
        disabledBorder: disabledBorder(radius: 10),
        focusedBorder: focusedBorder(radius: 10),
        focusedErrorBorder: errorBorder(radius: 10),
        errorBorder: errorBorder(radius: 10),
      ),
      initialCountryCode: widget.initialCountryCode,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      validator: (p0) {
        try {
          final number = p0?.number.trim() ?? '';
          if (number.isEmpty) {
            return "Please enter phone number".tr();
          }
          if (p0!.isValidNumber() == false) {
            return "Invalid phone number".tr();
          }
          return null;
        } catch (e) {
          return "Invalid phone number".tr();
        }
      },
    );
  }
}

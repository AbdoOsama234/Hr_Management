import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:intl_mobile_field/country_picker_dialog.dart';
import 'package:intl_mobile_field/mobile_number.dart';
import 'package:intl_mobile_field/intl_mobile_field.dart';
import '../../../../core/app_colors.dart';
import '../../core/text_style.dart';
import 'custom_text_field.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:country_picker/country_picker.dart';


import 'package:intl_phone_field/phone_number.dart';

import '../../core/constants.dart';
import 'custom_text_field.dart';

class CodePickerTextField extends StatefulWidget {
  final List<String>? countries;
  final String? hintName;
  // It must be a phone code like +20
  // not country code like EG
  final String? initCountryCode;
  final Widget? suffixIcon;
  final Function(PhoneNumber)? onInputChanged;
  final TextEditingController controller;
  final bool enabled;

  const CodePickerTextField({
    super.key,
    this.countries = Constants.supportedPhoneCodes,
    this.hintName,
    this.suffixIcon,
    required this.onInputChanged,
    this.enabled = true,
    required this.controller,
    this.initCountryCode,
  });

  @override
  State<CodePickerTextField> createState() => _CodePickerTextFieldState();
}

class _CodePickerTextFieldState extends State<CodePickerTextField> {
  late Country selectedCountry;
  late List<Country> allCountries;
  late List<Country> myFilteredCountries;

  @override
  void initState() {
    super.initState();
    initCountries();
  }

  /// Initialize [allCountries] and [myFilteredCountries] lists from the list of
  /// phone codes provided in the widget.
  ///
  /// If [widget.initCountryCode] is not null, set [selectedCountry] to the
  /// first matching country in [allCountries]. Otherwise, set it to the first
  /// item in [myFilteredCountries].
  ///
  /// [allCountries] is the complete list of countries from the
  /// [CountryService].
  ///
  /// [myFilteredCountries] is a subset of [allCountries] that only includes
  /// countries with a phone code in the list provided in the widget.
  void initCountries() {
    allCountries = CountryService().getAll();

    final targetPhoneCodes = (widget.countries ?? [])
        .map((e) => e.replaceAll('+', ''))
        .toList();

    myFilteredCountries = targetPhoneCodes
        .expand((code) => allCountries.where((c) => c.phoneCode == code))
        .toSet()
        .toList();

    final targetCode = (widget.initCountryCode ?? Constants.supportedPhoneCodes.first)
        .replaceAll('+', '');

    selectedCountry = allCountries.firstWhere(
          (c) => c.phoneCode == targetCode,
      orElse: () => myFilteredCountries.isNotEmpty
          ? myFilteredCountries.first
          : allCountries.first,
    );
  }

  void showCountryPickerBottomSheet(
      BuildContext context,
      Function(Country) onCountrySelected,
      ) {
    TextEditingController searchController = TextEditingController();
    List<Country> currentFilteredCountries = myFilteredCountries;
    Country? tempSelected = selectedCountry;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backGround,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SizedBox(
              height: 80.h,
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Choose Country".tr(),
                          style: AppTextStyle.smallHeadline,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (tempSelected != null) {
                              onCountrySelected(tempSelected!);
                            }
                            Navigator.pop(context);
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Done'.tr(),
                              style: AppTextStyle.body.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CustomTextField(
                      validator: (value) => null,
                      hint: 'Search'.tr(),
                      controller: searchController,
                      onChange: (query) {
                        setModalState(() {
                          if (query.isEmpty) {
                            currentFilteredCountries = myFilteredCountries;
                            return;
                          }

                          final lowerQuery = query.toLowerCase();

                          currentFilteredCountries = allCountries.where((country) {
                            final englishName = country.name.toLowerCase();
                            final arabicName = CountryLocalizations.of(context)
                                ?.countryName(countryCode: country.countryCode)
                                ?.toLowerCase() ??
                                englishName;
                            final phoneCode = country.phoneCode;

                            return englishName.contains(lowerQuery) ||
                                arabicName.contains(lowerQuery) ||
                                phoneCode.contains(query);
                          }).toList();
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Country List
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentFilteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = currentFilteredCountries[index];
                        final localizedName = CountryLocalizations.of(context)
                            ?.countryName(countryCode: country.countryCode) ??
                            country.name;
                        final isSelected = country == tempSelected;

                        return ListTile(
                          leading: Text(
                            country.flagEmoji,
                            style: AppTextStyle.headline,
                          ),
                          title: Text(
                            localizedName,
                            style: AppTextStyle.subTitle,
                          ),
                          subtitle: Text(
                            '+${country.phoneCode}',
                            style: AppTextStyle.hint,
                          ),
                          trailing: isSelected
                              ? const Icon(Icons.check, color: AppColors.primary)
                              : null,
                          onTap: () {
                            setModalState(() {
                              tempSelected = country;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      enable: widget.enabled,
      controller: widget.controller,
      hint: widget.hintName ?? 'Phone Number'.tr(),
      type: TextInputType.phone,
      prefix: GestureDetector(
        onTap: () {
          showCountryPickerBottomSheet(context, (Country country) {
            setState(() {
              selectedCountry = country;
              if (widget.onInputChanged != null) {
                widget.onInputChanged!(
                  PhoneNumber(
                    countryISOCode: selectedCountry.countryCode,
                    countryCode: "+${selectedCountry.phoneCode}",
                    number: widget.controller.text,
                  ),
                );
              }
            });
          });
        },
        child: Text(
          '+${selectedCountry.phoneCode} ${selectedCountry.flagEmoji}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "phone number is required".tr();
        } else {
          return null;
        }
      },
    );
  }
}

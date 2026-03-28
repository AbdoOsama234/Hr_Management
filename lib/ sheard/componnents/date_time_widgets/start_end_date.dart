import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_validation.dart';

import '../../../../../core/app_assets.dart';
import '../../../../../core/app_sized_box.dart';
import '../../../core/app_colors.dart';
import '../app_asset_image.dart';
import '../custom_text_field.dart';
import 'common.dart';

class DatesRow extends StatefulWidget {
  const DatesRow({
    super.key,
    required this.startDateController,
    required this.endDateController,
    this.isEnable = true,
    this.startTitel,
    this.endTitel,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final String? startTitel;
  final String? endTitel;
  final bool isEnable;
  final Function(DateTime) onStartDateChanged;
  final Function(DateTime) onEndDateChanged;
  @override
  State<DatesRow> createState() => _DatesRowState();
}

class _DatesRowState extends State<DatesRow> {
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late bool isEnable;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  @override
  void initState() {
    startDateController = widget.startDateController;
    endDateController = widget.endDateController;
    isEnable = widget.isEnable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.startTitel ?? 'start_date'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              AppSizedBox.h1,
              InkWell(
                onTap: isEnable
                    ? () async {
                        DateTime? value = await showDateEPicker(context);
                        if (value != null) {
                          start = value;
                          log('start');
                          log(start.toString());
                          startDateController.text = dateFoemated(
                            start.toString(),
                          );
                          widget.onStartDateChanged(start);
                        }
                      }
                    : null,
                child: CustomTextField(
                  enable: false,
                  controller: startDateController,
                  type: TextInputType.text,
                  hint: 'Enter Date'.tr(),
                  prefix: const AppAssetImage(
                    uri: AppAssets.calendar2,
                    color: AppColors.primary,
                  ),
                  validator: (value) {
                    return Validations.normalValidation(value);
                  },
                ),
              ),
              AppSizedBox.h3,
              Text(
                widget.endTitel ?? 'end_date'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              AppSizedBox.h1,
              InkWell(
                onTap: isEnable
                    ? () async {
                        DateTime? value = await showDateEPicker(context);
                        if (value != null) {
                          end = value;
                          log('end');
                          log(end.toString());
                          endDateController.text = dateFoemated(end.toString());
                          widget.onEndDateChanged(end);
                        }
                      }
                    : null,
                child: CustomTextField(
                  enable: false,
                  controller: endDateController,
                  type: TextInputType.text,
                  hint: 'Enter Date'.tr(),
                  prefix: const AppAssetImage(
                    uri: AppAssets.calendar2,
                    color: AppColors.primary,
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required'.tr();
                    } else if (start.isAfter(end)) {
                      log('First Date must be last end tome');
                      return 'First Date must be before end Date'.tr();
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

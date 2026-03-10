import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/features/componnents/date_time_widgets/common.dart';

import '../../../../../core/app_assets.dart';
import '../../../../../core/app_sized_box.dart';
import '../../../core/app_colors.dart';
import '../app_asset_image.dart';
import '../custom_text_field.dart';
import '../show_flutter_snackbar.dart';

class DatesRow extends StatefulWidget {
  const DatesRow({
    super.key,
    required this.startDateController,
    required this.endDateController,
    this.isEnable = true,
    this.startTitel,
    this.endTitel,
  });
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final String? startTitel;
  final String? endTitel;
  final bool isEnable;

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
              // Text(
              //   widget.startTitel ?? 'Start Date',
              //   style: const TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
              // AppSizedBox.h2,
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
                    return null;
                  },
                ),
              ),
              AppSizedBox.h3,
              // Text(
              //   widget.endTitel ?? 'End Date',
              //   style: const TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
              // AppSizedBox.h2,
              InkWell(
                onTap: isEnable
                    ? () async {
                        DateTime? value = await showDateEPicker(context);
                        if (value != null) {
                          end = value;
                          log('end');
                          log(end.toString());
                          endDateController.text = dateFoemated(end.toString());
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
                    if (start.isAfter(end)) {
                      log('First Date must be last end tome');
                      showFlutterSnackBar(
                        message: 'First Date must be before end Date'.tr(),
                        toastColor: Colors.red,
                      );
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

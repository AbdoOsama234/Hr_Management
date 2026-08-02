// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../core/app_sized_box.dart';

import '../custom_text_field.dart' show CustomTextField;
import '../show_app_toast.dart';
import 'common.dart';

class TimesRow extends StatefulWidget {
  const TimesRow({
    super.key,
    required this.startDateController,
    required this.endDateController,
    this.isEnable = true,
  });
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final bool isEnable;

  @override
  State<TimesRow> createState() => _TimesRowState();
}

class _TimesRowState extends State<TimesRow> {
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late bool isEnable;
  TimeOfDay start = TimeOfDay.now();
  TimeOfDay end = TimeOfDay.now();
  @override
  void initState() {
    startDateController = widget.startDateController;
    endDateController = widget.endDateController;
    isEnable = widget.isEnable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Start Time',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        AppSizedBox.h2,
        InkWell(
          onTap: isEnable
              ? () async {
                  TimeOfDay? value = await showPicker(context);
                  if (value != null) {
                    start = value;
                    log('start');
                    log(start.toString());
                    startDateController.text = start.format(context);
                  }
                }
              : null,
          child: CustomTextField(
            enable: false,
            controller: startDateController,
            type: TextInputType.text,
            hint: 'Enter Start Time',
            prefix: const Icon(Icons.date_range),
            validator: (value) {
              return null;
              // return Validations.normalValidation(
              //   value,
              //   name: 'your Start time',
              // );
            },
          ),
        ),
        AppSizedBox.h3,
        const Text(
          'End Time',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        AppSizedBox.h2,
        InkWell(
          onTap: isEnable
              ? () async {
                  TimeOfDay? value = await showPicker(context);
                  if (value != null) {
                    end = value;
                    log('end');
                    log(end.toString());
                    endDateController.text = end.format(context);
                  }
                }
              : null,
          child: CustomTextField(
            enable: false,
            controller: endDateController,
            type: TextInputType.text,
            hint: 'Enter End Time',
            prefix: const Icon(Icons.date_range),
            validator: (value) {
              log('object33');
              log(start.toString());
              log(end.toString());
              double startVal = toDouble(start);
              double endVal = toDouble(end);
              if (startVal > endVal) {
                log('start time must be befor end tome');
                CustomToast.show(
                  message: 'start time must be befor end time',
                  type: ToastType.error,
                );
                return 'start time must be befor end time';
              }
              log('object44');
              return null;
            },
          ),
        ),
      ],
    );
  }
}

double toDouble(TimeOfDay timeOfDay) {
  log('time');
  log(timeOfDay.toString());
  return timeOfDay.hour + timeOfDay.minute / 60.0;
}

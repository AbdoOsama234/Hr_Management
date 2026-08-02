import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_sized_box.dart';

import 'package:hr_manegement/core/app_validation.dart';

import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../ sheard/componnents/date_time_widgets/start_end_date.dart';
import '../../data/models/permission_model.dart';
import '../../data/models/permission_request.dart';

class PermissionRequestForm extends StatefulWidget {
  final Function(PermissionRequest model) onSubmit;
  final PermissionModel? request;
  final String? buttonText;
  const PermissionRequestForm({
    super.key,
    required this.onSubmit,
    this.request,
    this.buttonText,
  });

  @override
  State<PermissionRequestForm> createState() => _PermissionRequestFormState();
}

class _PermissionRequestFormState extends State<PermissionRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _hoursController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    if (widget.request != null) {
      _reasonController.text = widget.request!.requestNotes ?? '';
      _hoursController.text = widget.request!.hours?.toString() ?? '';
      _startDate = DateTime.tryParse(widget.request!.fromDatetime ?? '');
      _endDate = DateTime.tryParse(widget.request!.toDatetime ?? '');
      if (_startDate != null) {
        _startDateController.text = dateFoemated(_startDate.toString());
      }
      if (_endDate != null) {
        _endDateController.text = dateFoemated(_endDate.toString());
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _hoursController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DatesRow(
              startDateController: _startDateController,
              endDateController: _endDateController,
              startTitel: 'start_date'.tr(),
              endTitel: 'end_date'.tr(),
              onStartDateChanged: (value) {
                _startDate = value;
              },
              onEndDateChanged: (value) {
                _endDate = value;
              },
            ),
            AppSizedBox.h2,
            Text(
              'Permission Hours'.tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            AppSizedBox.h1,
            CustomTextField(
              controller: _hoursController,
              hint: 'Permission Hours'.tr(),
              type: const TextInputType.numberWithOptions(decimal: true),
              validator: Validations.numberValidation,
            ),
            AppSizedBox.h2,
            Text(
              'Reason'.tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            AppSizedBox.h1,
            CustomTextField(
              controller: _reasonController,
              hint: 'Reason'.tr(),
              type: TextInputType.multiline,
              max: 4,
              validator: Validations.normalValidation,
            ),
            AppSizedBox.h4,
            CustomButton(
              text: widget.buttonText ?? 'submit_request'.tr(),
              width: double.infinity,
              radius: 12,
              txtcolor: Colors.white,
              onTap: () {
                if (_formKey.currentState!.validate() &&
                    _startDate != null &&
                    _endDate != null) {
                  final model = PermissionRequest(
                    type: "test",
                    fromDatetime: _startDate!.toIso8601String(),
                    toDatetime: _endDate!.toIso8601String(),
                    hours: _hoursController.text.trim(),
                    requestNotes: _reasonController.text.trim(),
                  );

                  widget.onSubmit(model);

                  Navigator.pop(context);
                }
              },
            ),
            AppSizedBox.h4,
          ],
        ),
      ),
    );
  }
}

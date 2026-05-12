import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/app_validation.dart';

import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../ sheard/componnents/date_time_widgets/start_end_date.dart';
import '../../data/models/holiday_model.dart';

class HolidayRequestForm extends StatefulWidget {
  final Function(DateTime startDate, DateTime endDate, int days, String reason)
  onSubmit;

  final HolidayModel? holiday;
  final String? buttonText;

  const HolidayRequestForm({
    super.key,
    required this.onSubmit,
    this.holiday,
    this.buttonText,
  });

  @override
  State<HolidayRequestForm> createState() =>
      _HolidayRequestFormState();
}

class _HolidayRequestFormState extends State<HolidayRequestForm> {
  final _formKey = GlobalKey<FormState>();

  final _reasonController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  int get _calculatedDays {
    if (_startDate == null || _endDate == null) return 0;

    final days = _endDate!.difference(_startDate!).inDays + 1;
    return days > 0 ? days : 0;
  }

  @override
  void initState() {
    super.initState();

    if (widget.holiday != null) {
      _reasonController.text = widget.holiday!.requestNotes ?? '';

      _startDate = DateTime.tryParse(widget.holiday!.fromDate ?? '');
      _endDate = DateTime.tryParse(widget.holiday!.toDate ?? '');

      if (_startDate != null) {
        _startDateController.text = dateFoemated(_startDate.toString());
      }

      if (_endDate != null) {
        _endDateController.text = dateFoemated(_endDate.toString());
      }
    }
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select start and end date'.tr())),
      );
      return;
    }

    if (_calculatedDays <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('End date must be after start date'.tr())),
      );
      return;
    }

    widget.onSubmit(
      _startDate!,
      _endDate!,
      _calculatedDays,
      _reasonController.text.trim(),
    );

    Navigator.pop(context);
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
                setState(() {
                  _startDate = value;
                });
              },
              onEndDateChanged: (value) {
                setState(() {
                  _endDate = value;
                });
              },
            ),

            AppSizedBox.h2,

            Text(
              'Holiday Days'.tr(),
              style: const TextStyle(fontSize: 16),
            ),
            AppSizedBox.h1,

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _calculatedDays > 0
                    ? '$_calculatedDays ${'days'.tr()}'
                    : 'Select dates'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            AppSizedBox.h2,

            Text(
              'Reason'.tr(),
              style: const TextStyle(fontSize: 16),
            ),
            AppSizedBox.h1,

            CustomTextField(
              controller: _reasonController,
              hint: 'Reason'.tr(),
              type: TextInputType.multiline,
              max: 4,
              validator: (value) {
                return Validations.normalValidation(value);
              },
            ),

            AppSizedBox.h4,

            CustomButton(
              text: widget.buttonText ?? 'submit_request'.tr(),
              width: double.infinity,
              radius: 12,
              txtcolor: Colors.white,
              onTap: _submit,
            ),

            AppSizedBox.h4,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/app_validation.dart';

import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../ sheard/componnents/date_time_widgets/start_end_date.dart';
import '../../data/models/business_trip_model.dart';

class BusinessTripRequestForm extends StatefulWidget {
  final Function(DateTime startDate, DateTime endDate, int days, String reason)
  onSubmit;

  /// 👇 بدل request
  final BusinessTripModel? trip;

  final String? buttonText;

  const BusinessTripRequestForm({
    super.key,
    required this.onSubmit,
    this.trip,
    this.buttonText,
  });

  @override
  State<BusinessTripRequestForm> createState() =>
      _BusinessTripRequestFormState();
}

class _BusinessTripRequestFormState
    extends State<BusinessTripRequestForm> {
  final _formKey = GlobalKey<FormState>();

  final _reasonController = TextEditingController();
  final _daysController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    /// ✅ edit case
    if (widget.trip != null) {
      _reasonController.text = widget.trip!.requestNotes ?? '';
      _daysController.text = (widget.trip!.daysCount ?? 0).toString();

      _startDate = DateTime.tryParse(widget.trip!.fromDate ?? '');
      _endDate = DateTime.tryParse(widget.trip!.toDate ?? '');

      if (_startDate != null) {
        _startDateController.text =
            dateFoemated(_startDate.toString());
      }

      if (_endDate != null) {
        _endDateController.text =
            dateFoemated(_endDate.toString());
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _daysController.dispose();
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
            /// 📅 Dates
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

            /// ⏱ Days
            Text(
              'Business Trip Days'.tr(),
              style: const TextStyle(fontSize: 16),
            ),
            AppSizedBox.h1,

            CustomTextField(
              controller: _daysController,
              hint: 'Business Trip Days'.tr(),
              type: const TextInputType.numberWithOptions(decimal: false),
              validator: (value) {
                return Validations.numberValidation(value);
              },
            ),

            AppSizedBox.h2,

            /// 📝 Reason
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

            /// 🚀 Submit
            CustomButton(
              text: widget.buttonText ?? 'submit_request'.tr(),
              width: double.infinity,
              radius: 12,
              txtcolor: Colors.white,
              onTap: () {
                if (_formKey.currentState!.validate() &&
                    _startDate != null &&
                    _endDate != null) {
                  widget.onSubmit(
                    _startDate!,
                    _endDate!,
                    int.parse(_daysController.text.trim()),
                    _reasonController.text.trim(),
                  );

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
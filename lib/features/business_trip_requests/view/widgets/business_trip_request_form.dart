import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/features/componnents/custom_button.dart';
import 'package:hr_manegement/features/componnents/custom_text_field.dart';
import 'package:hr_manegement/core/app_validation.dart';

import '../../../componnents/date_time_widgets/common.dart';
import '../../../componnents/date_time_widgets/start_end_date.dart';
import '../../data/models/business_trip_request_model.dart';

class BusinessTripRequestForm extends StatefulWidget {
  final Function(DateTime startDate, DateTime endDate, int days, String reason) onSubmit;
  final BusinessTripRequestModel? request;
  final String? buttonText;
  const BusinessTripRequestForm({
    super.key,
    required this.onSubmit,
    this.request,
    this.buttonText,
  });

  @override
  State<BusinessTripRequestForm> createState() => _BusinessTripRequestFormState();
}

class _BusinessTripRequestFormState extends State<BusinessTripRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _daysController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    if (widget.request != null) {
      _reasonController.text = widget.request!.reason;
      _daysController.text = widget.request!.days.toString();
      _startDate = widget.request!.startDate;
      _endDate = widget.request!.endDate;
      _startDateController.text = dateFoemated(_startDate.toString());
      _endDateController.text = dateFoemated(_endDate.toString());
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
              'Business Trip Days'.tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
              onTap: () {
                if (_formKey.currentState!.validate() && _startDate != null && _endDate != null) {
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

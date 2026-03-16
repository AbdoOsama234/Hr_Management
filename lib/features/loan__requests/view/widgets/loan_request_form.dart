import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/features/componnents/custom_button.dart';
import 'package:hr_manegement/features/componnents/custom_text_field.dart';
import 'package:hr_manegement/features/componnents/date_time_widgets/common.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/features/componnents/app_asset_image.dart';
import 'package:hr_manegement/core/app_validation.dart';

import '../../data/models/loan_request_model.dart';

class LoanRequestForm extends StatefulWidget {
  final Function(DateTime date, double loan, String reason) onSubmit;
  final LoanRequestModel? request;
  final String? buttonText;
  const LoanRequestForm({
    super.key,
    required this.onSubmit,
    this.request,
    this.buttonText,
  });

  @override
  State<LoanRequestForm> createState() => _LoanRequestFormState();
}

class _LoanRequestFormState extends State<LoanRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _loanController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    if (widget.request != null) {
      _reasonController.text = widget.request!.reason;
      _loanController.text = widget.request!.loan.toString();
      _selectedDate = widget.request!.date;
      _dateController.text = dateFoemated(widget.request!.date.toString());
    }
    super.initState();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _loanController.dispose();
    _dateController.dispose();
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
            Text(
              'Date'.tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            AppSizedBox.h1,
            InkWell(
              onTap: () async {
                DateTime? value = await showDateEPicker(context);
                if (value != null) {
                  setState(() {
                    _selectedDate = value;
                    _dateController.text = dateFoemated(value.toString());
                  });
                }
              },
              child: CustomTextField(
                enable: false,
                controller: _dateController,
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
            AppSizedBox.h2,
            Text(
              'Loan Amount'.tr(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            AppSizedBox.h1,
            CustomTextField(
              controller: _loanController,
              hint: 'Loan Amount'.tr(),
              type: const TextInputType.numberWithOptions(decimal: true),
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
              hint: 'reason'.tr(),
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
                if (_formKey.currentState!.validate() &&
                    _selectedDate != null) {
                  widget.onSubmit(
                    _selectedDate!,
                    double.parse(_loanController.text.trim()),
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

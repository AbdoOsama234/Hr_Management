import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/app_validation.dart';

import '../../../../ sheard/componnents/app_asset_image.dart';
import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';

import '../../data/models/loan_model.dart';

class LoanRequestForm extends StatefulWidget {
  final Function(
    DateTime date,
    String amount,
    String loanType,
    String installments,
    String notes,
  )
  onSubmit;

  final LoanModel? request;
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

  final _amountController = TextEditingController();
  final _loanTypeController = TextEditingController();
  final _installmentsController = TextEditingController();
  final _notesController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    if (widget.request != null) {
      _amountController.text = widget.request?.amount ?? '';
      _loanTypeController.text = widget.request?.loanType ?? '';
      _installmentsController.text =
          widget.request?.installments?.toString() ?? '';
      _notesController.text = widget.request?.notes ?? '';

      if (widget.request?.requestDate != null) {
        _selectedDate = DateTime.tryParse(widget.request!.requestDate!);
        if (_selectedDate != null) {
          _dateController.text = dateFoemated(_selectedDate.toString());
        }
      }
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _loanTypeController.dispose();
    _installmentsController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a date'.tr())));
      return;
    }

    widget.onSubmit(
      _selectedDate!,
      _amountController.text.trim(),
      _loanTypeController.text.trim(),
      _installmentsController.text.trim(),
      _notesController.text.trim(),
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
            /// DATE
            Text('Date'.tr(), style: const TextStyle(fontSize: 16)),
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

            /// AMOUNT
            Text('Loan Amount'.tr(), style: const TextStyle(fontSize: 16)),
            AppSizedBox.h1,
            CustomTextField(
              controller: _amountController,
              hint: 'Loan Amount'.tr(),
              type: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                return Validations.numberValidation(value);
              },
            ),
            AppSizedBox.h2,

            /// LOAN TYPE
            Text('Loan Type'.tr(), style: const TextStyle(fontSize: 16)),
            AppSizedBox.h1,
            CustomTextField(
              controller: _loanTypeController,
              hint: 'Loan Type'.tr(),
              type: TextInputType.text,
              validator: (value) {
                return Validations.normalValidation(value);
              },
            ),
            AppSizedBox.h2,

            /// INSTALLMENTS
            Text('Installments'.tr(), style: const TextStyle(fontSize: 16)),
            AppSizedBox.h1,
            CustomTextField(
              controller: _installmentsController,
              hint: 'Installments'.tr(),
              type: TextInputType.number,
              validator: (value) {
                return Validations.numberValidation(value);
              },
            ),
            AppSizedBox.h2,

            /// NOTES
            Text('Notes'.tr(), style: const TextStyle(fontSize: 16)),
            AppSizedBox.h1,
            CustomTextField(
              controller: _notesController,
              hint: 'Notes'.tr(),
              type: TextInputType.multiline,
              max: 4,
              validator: (value) {
                return Validations.normalValidation(value);
              },
            ),
            AppSizedBox.h4,

            /// BUTTON
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

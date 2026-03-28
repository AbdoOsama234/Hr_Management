import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_sized_box.dart';




import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../ sheard/componnents/date_time_widgets/start_end_date.dart';
import '../../data/models/holiday_request_model.dart';

class HolidayRequestForm extends StatefulWidget {
  final Function(DateTime startDate, DateTime endDate, String reason) onSubmit;
  final HolidayRequestModel? request;
  final String? buttonText;
  const HolidayRequestForm({
    super.key,
    required this.onSubmit,
    this.request,
    this.buttonText,
  });

  @override
  State<HolidayRequestForm> createState() => _HolidayRequestFormState();
}

class _HolidayRequestFormState extends State<HolidayRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  @override
  void initState() {
    if (widget.request != null) {
      _reasonController.text = widget.request!.reason;
      _startDate = widget.request!.startDate;
      _endDate = widget.request!.endDate;
      startDateController.text = dateFoemated(
        widget.request!.startDate.toString(),
      );
      endDateController.text = dateFoemated(widget.request!.endDate.toString());
    }
    super.initState();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  TextEditingController endDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
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
              endDateController: endDateController,
              startDateController: startDateController,
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
            CustomTextField(
              controller: _reasonController,
              hint: 'reason'.tr(),
              type: TextInputType.multiline,
              max: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'reason_required'.tr();
                }
                return null;
              },
            ),
            AppSizedBox.h4,
            CustomButton(
              text: widget.buttonText ?? 'submit_request'.tr(),
              width: double.infinity,
              radius: 12,
              txtcolor: Colors.white,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSubmit(
                    _startDate!,
                    _endDate!,
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

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/features/componnents/custom_button.dart';
import 'package:hr_manegement/features/componnents/custom_text_field.dart';

class HolidayRequestForm extends StatefulWidget {
  final Function(DateTime startDate, DateTime endDate, String reason) onSubmit;

  const HolidayRequestForm({
    super.key,
    required this.onSubmit,
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
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.black,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 5.w,
        right: 5.w,
        top: 3.h,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 12.w,
                  height: 0.6.h,
                  decoration: BoxDecoration(
                    color: AppColors.textSub.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              AppSizedBox.h3,
              Text(
                'request_holiday'.tr(),
                style: AppTextStyle.subHeadline.copyWith(
                  color: AppColors.textMain,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSizedBox.h3,
              _buildDatePickerField(
                label: 'start_date'.tr(),
                date: _startDate,
                onTap: () => _selectDate(context, true),
              ),
              AppSizedBox.h2,
              _buildDatePickerField(
                label: 'end_date'.tr(),
                date: _endDate,
                onTap: () => _selectDate(context, false),
                isEnabled: _startDate != null,
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
          text: 'submit_request'.tr(),
          width: double.infinity,
          radius: 12,
          txtcolor: Colors.white,
          onTap: () {
            final isValid = _formKey.currentState?.validate() ?? false;

            if (!isValid) return;

            if (_startDate == null || _endDate == null)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('select_dates_warning'.tr()),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }

            if (_startDate!.isAfter(_endDate!)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('invalid_date_range'.tr()),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              return;
            }

            widget.onSubmit(
              _startDate!,
              _endDate!,
              _reasonController.text.trim(),
            );

            Navigator.pop(context);
          },
        )
  ,
            AppSizedBox.h4,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePickerField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
    bool isEnabled = true,
  }) {
    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.backGround2 : AppColors.backGround2.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyle.smallBody.copyWith(
                    color: AppColors.textSub,
                  ),
                ),
                if (date != null) ...[
                  SizedBox(height: 0.5.h),
                  Text(
                    DateFormat('yyyy-MM-dd').format(date),
                    style: AppTextStyle.title.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
            Icon(
              Icons.calendar_today_rounded,
              color: AppColors.primary,
              size: 5.w,
            ),
          ],
        ),
      ),
    );
  }
}

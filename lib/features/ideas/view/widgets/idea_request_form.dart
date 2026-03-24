import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_validation.dart';
import 'package:hr_manegement/features/componnents/custom_button.dart';
import 'package:hr_manegement/features/componnents/custom_text_field.dart';
import 'package:hr_manegement/features/componnents/custom_drop_down.dart';
import 'package:hr_manegement/features/componnents/custom_file_picker.dart';
import 'package:hr_manegement/features/componnents/date_time_widgets/common.dart';
import '../../data/models/idea_model.dart';

class IdeaRequestForm extends StatefulWidget {
  final Function({
    required DateTime date,
    required String ideaExplain,
    required String ideaLink,
    File? ideaFile,
    required IdeaType type,
  })
  onSubmit;
  final IdeaModel? request;
  final String? buttonText;

  const IdeaRequestForm({
    super.key,
    required this.onSubmit,
    this.request,
    this.buttonText,
  });

  @override
  State<IdeaRequestForm> createState() => _IdeaRequestFormState();
}

class _IdeaRequestFormState extends State<IdeaRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final _explainController = TextEditingController();
  final _linkController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  File? _selectedFile;
  IdeaType? _selectedType;

  @override
  void initState() {
    if (widget.request != null) {
      _explainController.text = widget.request!.ideaExplain;
      _linkController.text = widget.request!.ideaLink;
      _selectedDate = widget.request!.date;
      _dateController.text = dateFoemated(widget.request!.date.toString());
      _selectedFile = widget.request!.ideaFile;
      _selectedType = widget.request!.type;
    }
    super.initState();
  }

  @override
  void dispose() {
    _explainController.dispose();
    _linkController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _dateController,
              hint: 'Date'.tr(),
              suffixIcon: const Icon(
                Icons.calendar_today,
                color: AppColors.primary,
              ),
              readOnly: true,
              type: TextInputType.text,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                    _dateController.text = dateFoemated(date.toString());
                  });
                }
              },
              validator: (value) {
                if (_selectedDate == null) {
                  return 'This field is required'.tr();
                }
                return null;
              },
            ),
            AppSizedBox.h2,
            CustomDropDownMenu(
              label: 'idea_type'.tr(),
              value: _selectedType,
              items: IdeaType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.name.tr()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value as IdeaType;
                });
              },
              validator: (value) {
                if (_selectedType == null) {
                  return 'This field is required'.tr();
                }
                return null;
              },
            ),
            AppSizedBox.h2,
            CustomTextField(
              controller: _explainController,
              hint: 'idea_explain'.tr(),
              type: TextInputType.multiline,
              max: 4,
              validator: Validations.normalValidation,
            ),
            AppSizedBox.h2,
            CustomTextField(
              controller: _linkController,
              hint: 'idea_link'.tr(),
              type: TextInputType.url,
              validator: Validations.linkValidation,
            ),
            AppSizedBox.h2,
            CustomFilePicker(
              label: 'idea_file'.tr(),
              selectedFile: _selectedFile,
              onFilePicked: (file) {
                setState(() {
                  _selectedFile = file;
                });
              },
              onFileRemoved: () {
                setState(() {
                  _selectedFile = null;
                });
              },
            ),
            AppSizedBox.h4,
            CustomButton(
              text: widget.buttonText ?? 'submit'.tr(),
              width: double.infinity,
              radius: 12,
              txtcolor: Colors.white,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSubmit(
                    date: _selectedDate!,
                    ideaExplain: _explainController.text.trim(),
                    ideaLink: _linkController.text.trim(),
                    ideaFile: _selectedFile,
                    type: _selectedType!,
                  );
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

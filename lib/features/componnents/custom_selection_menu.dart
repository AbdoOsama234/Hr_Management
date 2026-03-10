import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/text_style.dart';

class CustomSelectionMenu extends StatelessWidget {
  final String label;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const CustomSelectionMenu({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      initialValue: value,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.tr(), style: AppTextStyle.title),
            AppSizedBox.h1,
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.backGround2.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: state.hasError
                      ? Colors.red.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.1),
                ),
              ),
              child: Row(
                children: items.map((item) {
                  final bool isSelected = value == item;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        onChanged(item);
                        state.didChange(item);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio<String>(
                              value: item,
                              groupValue: value,
                              onChanged: (val) {
                                onChanged(val);
                                state.didChange(val);
                              },
                              activeColor: Colors.white,
                            ),
                            Flexible(
                              child: Text(
                                item.tr(),
                                style: AppTextStyle.body.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textMain,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 12),
                child: Text(
                  state.errorText ?? "",
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}

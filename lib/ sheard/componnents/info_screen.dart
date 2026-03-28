import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';

import '../../../../core/app_sized_box.dart';
import '../../../../core/text_style.dart';
import 'custom_button.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({
    super.key,
    required this.title,
    required this.subTitle,
    required this.buttonText,
    required this.color,
    required this.onTap,
    required this.icon,
  });
  final String title;
  final String subTitle;
  final String buttonText;
  final Color color;
  final Function() onTap;
  final IconData icon;
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
              child: Icon(widget.icon, size: 80, color: AppColors.white),
            ),
            AppSizedBox.h3,
            Text(widget.title, style: AppTextStyle.title),
            AppSizedBox.h3,
            Text(
              widget.subTitle,
              textAlign: TextAlign.center,
              style: AppTextStyle.subTitle.copyWith(color: AppColors.grey),
            ),
            AppSizedBox.h3,
            CustomButton(
              text: widget.buttonText,
              butcolor: AppColors.primary,
              txtcolor: AppColors.white,
              onTap: () {
                widget.onTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}

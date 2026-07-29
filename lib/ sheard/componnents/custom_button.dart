import 'package:hr_manegement/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

import '../../data/storage/local/app_prefs.dart';
import 'loading_widget.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final VoidCallback? onTap;
  final double radius;
  final double fontsize;
  final FontWeight fontweight;
  final Color butcolor;
  final Widget? iconRight;
  final Widget? iconLeft;
  final Color? txtcolor;
  final bool isLoading;
  const CustomButton({
    required this.text,
    this.isLoading = false,
    this.height,
    this.width,
    this.butcolor = AppColors.primary,
    this.fontsize = 14,
    required this.onTap,
    this.radius = Constants.defaultRadius,
    super.key,
    this.txtcolor ,
    this.fontweight = FontWeight.w600,
    this.iconRight,
    this.iconLeft,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoaderWidget()
        : Container(
      height: height ?? 6.4.h,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.sp),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(butcolor),
          shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius.sp)),
            ),
          ),
        ),
        onPressed: onTap,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (iconRight != null) ...[
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 2.w,
                    end: 2.w,
                  ),
                  child: iconRight,
                ),
              ],
              Text(
                text,
                style: AppTextStyle.title.copyWith(
                  color: AppColors.white,
                  fontSize: fontsize.sp,
                  fontWeight: fontweight,
                  fontFamily:
                  getIt<AppPreferences>().lang == Constants.arLanguage
                      ? Constants.arFont
                      : Constants.enFont,
                ),
              ),
              if (iconLeft != null) ...[
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 2.w,
                    end: 2.w,
                  ),
                  child: iconLeft,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
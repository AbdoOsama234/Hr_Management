import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/text_style.dart';

void showSuccessesAppDialog({
  required BuildContext context,
  String? message,
  String? title,
  IconData? icon,
  Color? color,
}) {
  showAppDialog(
    context,
    color: color ?? AppColors.mintGreen,
    message: message ?? 'Your booking has been ',
    title: title ?? 'Successes',
    icon: icon ?? Icons.done,
  );
}

void showErorrAppDialog({
  required BuildContext context,
  String? message,
  String? title,
  IconData? icon,
  Color? color,
}) {
  showAppDialog(
    context,
    color: color ?? AppColors.red,
    message: message ?? 'Your booking has been',
    title: title ?? 'Erorr',
    icon: icon ?? Icons.close,
  );
}

void showInfoAppDialog({
  required BuildContext context,
  String? message,
  String? title,
  IconData? icon,
  Color? color,
}) {
  showAppDialog(
    context,
    color: color ?? AppColors.blue,
    message: message ?? 'Your booking has been ',
    title: title ?? 'information',
    icon: icon ?? Icons.info_outline_rounded,
  );
}

void showAppDialog(
  BuildContext context, {
  required String message,
  required String title,
  required IconData icon,
  required Color color,
}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.leftSlide,
    customHeader: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, size: 60, color: AppColors.white),
    ),
    title: title,
    titleTextStyle: AppTextStyle.title,
    desc: message,
    descTextStyle: AppTextStyle.hint.copyWith(),
    //btnCancelOnPress: () {},
    btnOkColor: AppColors.black,
    btnOkText: 'ok',

    btnOkOnPress: () {},
  ).show();
}

void showCustomDialog(
  BuildContext context, {
  required String message,
  required String title,
  required IconData icon,
  required Color color,
  bool dismissOnTouchOutside = true,
  void Function()? btnOkOnPress,
  void Function()? btnCancelOnPress,
  DialogType dialogType = DialogType.success,
}) {
  AwesomeDialog(
    dismissOnTouchOutside: dismissOnTouchOutside,
    context: context,
    dialogType: dialogType,
    animType: AnimType.leftSlide,
    customHeader: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, size: 60, color: AppColors.white),
    ),
    title: title,
    titleTextStyle: AppTextStyle.title,
    desc: message,
    descTextStyle: AppTextStyle.hint.copyWith(),
    btnCancelOnPress: btnCancelOnPress,
    btnOkColor: AppColors.black,
    btnCancelText: "Cancel".tr(),
    btnOkText: 'Ok'.tr(),
    btnOkOnPress: btnOkOnPress,
  ).show();
}

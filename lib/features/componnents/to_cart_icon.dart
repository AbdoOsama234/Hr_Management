import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';

GestureDetector addRemoveIconButton(
    {required Function onTap,
    required IconData iconData,
    double size = 20,
    double padding = 5,
    double width = 2,
    Color borderColor = AppColors.primary,
    Color iconColor = AppColors.primary}) {
  return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: width),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          size: size,
          color: iconColor,
        ),
      ));
}

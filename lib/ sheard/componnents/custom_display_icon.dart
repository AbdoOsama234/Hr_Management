import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:flutter/material.dart';

class CustomDisplayIcon extends StatelessWidget {
  const CustomDisplayIcon({
    super.key,
    required this.iconData,
    this.textColor = Colors.black,
    this.iconColor = Colors.white,
    required this.titleIcon,
  });
  final IconData iconData;
  final String titleIcon;
  final Color iconColor;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Row(
        children: [
          Icon(iconData, size: 30, color: Colors.white),
          AppSizedBox.w1,
          Text(titleIcon, style: TextStyle(fontSize: 10, color: textColor)),
        ],
      ),
    );
  }
}

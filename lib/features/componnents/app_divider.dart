import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider(
      {super.key,
      this.thickness = 2,
      this.padding = 10,
      this.color = Colors.grey});
  final double? thickness;
  final double? padding;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding ?? 10),
      child: Divider(
        thickness: thickness ?? 2,
        color: color ?? Colors.grey.shade300,
      ),
    );
  }
}

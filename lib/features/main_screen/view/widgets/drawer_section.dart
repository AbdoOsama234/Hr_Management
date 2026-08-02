import 'package:flutter/material.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import 'package:hr_manegement/my_app.dart';

class DrawerSection extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const DrawerSection({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  State<DrawerSection> createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<DrawerSection> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: MyApp.isDark
            ? Colors.white.withValues(alpha: 0.03)
            : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          /// 🔥 Header (زي DaySection)
          GestureDetector(
            onTap: () => setState(() => expanded = !expanded),
            child: Row(
              children: [
                Icon(widget.icon, color: AppColors.primary),

                SizedBox(width: 3.w),

                Expanded(
                  child: Text(
                    widget.title,
                    style: AppTextStyle.body.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: AppColors.textMain,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                /// arrow
                Icon(
                  expanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),

          SizedBox(height: expanded ? 1.h : 0),

          /// 🔻 Content
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Column(children: widget.children),
            secondChild: const SizedBox(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../ sheard/componnents/file_preview_screen.dart';
import '../../../../ sheard/componnents/icon_button.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../../../../core/helpers/luanch_url.dart';
import '../../controller/ideas_cubit.dart';
import '../../data/models/idea_model.dart';
import '../../../../my_app.dart';
import '../screens/update_idea_screen.dart';

class IdeaRequestCard extends StatelessWidget {
  final IdeaModel idea;

  const IdeaRequestCard({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.backGround2,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 4.w,
                    color: AppColors.primary.withOpacity(0.6),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    dateFoemated(idea.date.toString()),
                    style: AppTextStyle.hint.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildTypeChip(idea.type),
            ],
          ),
          AppSizedBox.h1,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildStatusChip(idea.status)],
          ),
          AppSizedBox.h2,
          Text(
            idea.ideaExplain,
            style: AppTextStyle.title.copyWith(
              color: AppColors.textMain,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (idea.ideaLink.isNotEmpty) ...[
            AppSizedBox.h1,
            GestureDetector(
              onTap: () {
                LaunchHelper.openLink(idea.ideaLink);
              },
              child: Row(
                children: [
                  Icon(Icons.link, size: 4.w, color: AppColors.blue),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: Text(
                      idea.ideaLink,
                      style: AppTextStyle.smallBody.copyWith(
                        color: AppColors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (idea.ideaFile != null) ...[
            AppSizedBox.h1,
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilePreviewScreen(
                      file: idea.ideaFile!,
                      title: idea.ideaFile!.path.split('/').last,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.attach_file_rounded,
                    size: 4.w,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 1.w),
                  Expanded(
                    child: Text(
                      idea.ideaFile!.path.split('/').last,
                      style: AppTextStyle.smallBody.copyWith(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],

          AppSizedBox.h2,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppIcon(
                icon: Icon(Icons.edit, color: AppColors.primary),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BlocProvider.value(
                        value: IdeasCubit.get(context),
                        child: UpdateIdeaScreen(idea: idea),
                      ),
                    ),
                  );
                },
              ),
              AppSizedBox.w2,
              AppIcon(
                icon: Icon(Icons.delete, color: AppColors.primary),
                onTap: () {
                  showAppOptionBottomSheet(
                    context: context,
                    title: "Are you sure you want to delete this request?".tr(),
                    option1: BottomSheetOption(
                      title: "Yes".tr(),
                      backGroundColor: Colors.transparent,
                      onTap: () {
                        context.read<IdeasCubit>().deleteIdea(idea.id);
                        Navigator.pop(context);
                      },
                    ),
                    option2: BottomSheetOption(
                      title: "No".tr(),
                      backGroundColor: AppColors.primary,
                      textColor: AppColors.white,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(IdeaStatus status) {
    Color color;
    String label;

    switch (status) {
      case IdeaStatus.pending:
        color = AppColors.orange;
        label = 'status_pending'.tr();
        break;
      case IdeaStatus.approved:
        color = AppColors.mintGreen;
        label = 'status_approved'.tr();
        break;
      case IdeaStatus.rejected:
        color = AppColors.rose;
        label = 'status_rejected'.tr();
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(MyApp.isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: AppTextStyle.smallBody.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTypeChip(IdeaType type) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.4.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Text(
        type.name.tr(),
        style: AppTextStyle.smallBody.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

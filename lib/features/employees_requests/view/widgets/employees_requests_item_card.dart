import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/custom_button.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../../../../ sheard/componnents/file_preview_screen.dart';
import '../../../../core/helpers/luanch_url.dart';
import '../../data/models/employees_requests_model.dart';
import '../../controller/employees_requests_cubit.dart';
import '../../../../my_app.dart';

class EmployeesRequestsItemCard extends StatelessWidget {
  final EmployeesRequestsModel request;

  const EmployeesRequestsItemCard({super.key, required this.request});

  void _showActionBottomSheet(BuildContext context, RequestStatus newStatus) {
    final notesController = TextEditingController(
      text: request.changeStateNotes,
    );
    final formKey = GlobalKey<FormState>();

    showAppBottomSheet(
      context: context,
      title: newStatus == RequestStatus.accepted
          ? 'accept_request'.tr()
          : 'refuse_request'.tr(),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: notesController,
              hint: 'change_state_notes'.tr(),
              type: TextInputType.multiline,
              validator: (v) => null,
              max: 3,
            ),
            AppSizedBox.h3,
            CustomButton(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  context.read<EmployeesRequestsCubit>().updateRequestState(
                    requestId: request.id,
                    newStatus: newStatus,
                    changeStateNotes: notesController.text,
                  );
                  Navigator.pop(context);
                }
              },
              text: 'confirm'.tr(),
            ),
          ],
        ),
      ),
    );
  }

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
                    color: AppColors.primary.withValues(alpha: 0.6),
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    dateFoemated(request.date.toString()),
                    style: AppTextStyle.hint.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              _buildTypeChip(request.type),
            ],
          ),
          AppSizedBox.h1,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildStatusChip(request.status)],
          ),
          AppSizedBox.h2,
          _buildRequestContent(context),
          if (request.changeStateNotes.isNotEmpty) ...[
            AppSizedBox.h2,
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'change_state_notes'.tr(),
                    style: AppTextStyle.hint.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSizedBox.h1,
                  Text(
                    request.changeStateNotes,
                    style: AppTextStyle.smallBody.copyWith(
                      color: AppColors.textMain,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (request.status == RequestStatus.pindding) ...[
            AppSizedBox.h2,
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        _showActionBottomSheet(context, RequestStatus.accepted),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1.2.h),
                      decoration: BoxDecoration(
                        color: AppColors.mintGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.mintGreen.withValues(alpha: 0.3),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: AppColors.mintGreen,
                            size: 4.5.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'accept'.tr(),
                            style: AppTextStyle.body.copyWith(
                              color: AppColors.mintGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        _showActionBottomSheet(context, RequestStatus.refused),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 1.2.h),
                      decoration: BoxDecoration(
                        color: AppColors.rose.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.rose.withValues(alpha: 0.3),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cancel_outlined,
                            color: AppColors.rose,
                            size: 4.5.w,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'refuse'.tr(),
                            style: AppTextStyle.body.copyWith(
                              color: AppColors.rose,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRequestContent(BuildContext context) {
    switch (request.type) {
      case RequestType.businessTrip:
        final bRequest = request.businessTripRequestModel;
        if (bRequest == null) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${dateFoemated(bRequest.startDate.toString())} \u2192 ${dateFoemated(bRequest.endDate.toString())}',
              style: AppTextStyle.smallBody.copyWith(color: AppColors.textMain),
            ),
            AppSizedBox.h1,
            Text(
              bRequest.reason,
              style: AppTextStyle.title.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
          ],
        );
      case RequestType.errand:
        final eRequest = request.errandRequestModel;
        if (eRequest == null) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${eRequest.days} ${'Days'.tr()}',
              style: AppTextStyle.smallBody.copyWith(color: AppColors.primary),
            ),
            AppSizedBox.h1,
            Text(
              eRequest.reason,
              style: AppTextStyle.title.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
          ],
        );
      case RequestType.holiday:
        final hRequest = request.holidayRequestModel;
        if (hRequest == null) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${dateFoemated(hRequest.startDate.toString())} \u2192 ${dateFoemated(hRequest.endDate.toString())}',
              style: AppTextStyle.smallBody.copyWith(color: AppColors.textMain),
            ),
            AppSizedBox.h1,
            Text(
              hRequest.reason,
              style: AppTextStyle.title.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
          ],
        );
      case RequestType.loan:
        final lRequest = request.loanRequestModel;
        if (lRequest == null) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${lRequest.loan}',
              style: AppTextStyle.smallBody.copyWith(color: AppColors.primary),
            ),
            AppSizedBox.h1,
            Text(
              lRequest.reason,
              style: AppTextStyle.title.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
          ],
        );
      case RequestType.idea:
        final iRequest = request.idea;
        if (iRequest == null) return const SizedBox();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              iRequest.ideaExplain,
              style: AppTextStyle.title.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textMain,
              ),
            ),
            if (iRequest.ideaLink.isNotEmpty) ...[
              AppSizedBox.h1,
              GestureDetector(
                onTap: () {
                  LaunchHelper.openLink(iRequest.ideaLink);
                },
                child: Row(
                  children: [
                    Icon(Icons.link, size: 4.w, color: AppColors.blue),
                    SizedBox(width: 1.w),
                    Expanded(
                      child: Text(
                        iRequest.ideaLink,
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
            if (iRequest.ideaFile != null) ...[
              AppSizedBox.h1,
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilePreviewScreen(
                        file: iRequest.ideaFile!,
                        title: iRequest.ideaFile!.path.split('/').last,
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
                        iRequest.ideaFile!.path.split('/').last,
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
          ],
        );
      case RequestType.permission:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizedBox.h1,
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 4.w,
                  color: AppColors.primary.withValues(alpha: 0.6),
                ),
                SizedBox(width: 2.w),
              ],
            ),
          ],
        );
    }
  }

  Widget _buildStatusChip(RequestStatus status) {
    Color color;
    String label;

    switch (status) {
      case RequestStatus.pindding:
        color = AppColors.orange;
        label = 'status_pending'.tr();
        break;
      case RequestStatus.accepted:
        color = AppColors.mintGreen;
        label = 'status_accepted'.tr();
        break;
      case RequestStatus.refused:
        color = AppColors.rose;
        label = 'status_refused'.tr();
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: MyApp.isDark ? 0.15 : 0.1),
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

  Widget _buildTypeChip(RequestType type) {
    String label;
    switch (type) {
      case RequestType.holiday:
        label = 'type_holiday'.tr();
        break;
      case RequestType.permission:
        label = 'type_permission'.tr();
        break;
      case RequestType.loan:
        label = 'type_loan'.tr();
        break;
      case RequestType.businessTrip:
        label = 'type_business_trip'.tr();
        break;
      case RequestType.errand:
        label = 'type_errand'.tr();
        break;
      case RequestType.idea:
        label = 'type_idea'.tr();
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.4.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: AppTextStyle.hint.copyWith(
          color: AppColors.primary,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

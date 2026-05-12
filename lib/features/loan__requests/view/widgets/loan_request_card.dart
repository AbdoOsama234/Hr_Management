import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:hr_manegement/core/text_style.dart';

import 'package:hr_manegement/features/loan__requests/controller/loan_state.dart';

import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/screen_builder/screen_builder.dart';
import '../../../../ sheard/componnents/date_time_widgets/common.dart';
import '../../../../ sheard/componnents/icon_button.dart';
import '../../../../ sheard/componnents/show_app_toast.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';

import '../../../../core/helpers/format_price_helper.dart'
    show FormatPriceHelper;

import '../../controller/loan_cubit.dart';

import '../../data/models/loan_model.dart';
import '../../data/models/loan_request.dart';

import '../../../../my_app.dart';

import 'loan_request_form.dart';

class LoanRequestCard extends StatelessWidget {

  final LoanModel request;

  const LoanRequestCard({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin:
      EdgeInsets.only(bottom: 2.h),

      padding:
      EdgeInsets.all(4.w),

      decoration: BoxDecoration(
        color:
        AppColors.backGround2,

        borderRadius:
        BorderRadius.circular(
          20,
        ),

        border: Border.all(
          color:
          AppColors.borderColor,
        ),

        boxShadow: [

          BoxShadow(
            color:
            AppColors.shadowColor,

            blurRadius: 10,

            offset:
            const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          /// DATE + STATUS
          Row(
            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

            children: [

              Row(
                children: [

                  Icon(
                    Icons
                        .calendar_today_rounded,

                    size: 4.w,

                    color: AppColors
                        .primary
                        .withOpacity(
                      0.6,
                    ),
                  ),

                  SizedBox(
                    width: 2.w,
                  ),

                  Text(
                    _formatDate(
                      request
                          .requestDate,
                    ),

                    style: AppTextStyle
                        .hint
                        .copyWith(
                      color:
                      AppColors
                          .textMain,

                      fontWeight:
                      FontWeight
                          .bold,
                    ),
                  ),
                ],
              ),

              _buildStatusChip(
                request.status,
              ),
            ],
          ),

          AppSizedBox.h1,

          /// AMOUNT
          Text(
            FormatPriceHelper
                .formatPrice(
              request.amount ?? "0",
            ),

            style:
            AppTextStyle.body
                .copyWith(
              color:
              AppColors.primary,

              fontWeight:
              FontWeight.bold,
            ),
          ),

          AppSizedBox.h2,

          /// TYPE
          Text(
            request.loanType ?? "--",

            style:
            AppTextStyle.title
                .copyWith(
              color:
              AppColors.textMain,

              fontWeight:
              FontWeight.w600,
            ),
          ),

          AppSizedBox.h2,

          /// NOTES
          if (request.notes != null &&
              request.notes!
                  .isNotEmpty)

            Text(
              request.notes!,

              style:
              AppTextStyle.body,
            ),

          AppSizedBox.h2,

          /// ACTIONS
          Row(
            mainAxisAlignment:
            MainAxisAlignment.end,

            children: [

              BlocConsumer<
                  LoanCubit,
                  LoanState>(

                buildWhen:
                    (
                    previous,
                    current,
                    ) =>

                current
                is UpdateLoanLoading ||

                    current
                    is UpdateLoanSuccess ||

                    current
                    is UpdateLoanError,

                listener: (
                    context,
                    state,
                    ) {

                  if (state
                  is UpdateLoanError) {

                    CustomToast.show(
                      message:
                      state.error
                          .orEmpty(),

                      type:
                      ToastType.error,
                    );
                  }
                },

                builder: (
                    context,
                    state,
                    ) {

                  return CustomApiBuilderView(

                    isLoading:
                    state
                    is UpdateLoanLoading &&
                        state.id ==
                            request.id,

                    isError:
                    state
                    is UpdateLoanError,

                    showErrorView:
                    false,

                    showEmptyView:
                    false,

                    loadingWidget:
                    const LoaderWidget(
                      size: 40,
                    ),

                    contentBuilder:
                        () => updateIcon(),

                    onRetry:
                        () => updateIcon(),

                    errorMessage:
                    state
                    is UpdateLoanError
                        ? state.error
                        : null,
                  );
                },
              ),

              AppSizedBox.w2,

              BlocConsumer<
                  LoanCubit,
                  LoanState>(

                buildWhen:
                    (
                    previous,
                    current,
                    ) =>

                current
                is DeleteLoanLoading ||

                    current
                    is DeleteLoanSuccess ||

                    current
                    is DeleteLoanError,

                listener: (
                    context,
                    state,
                    ) {

                  if (state
                  is DeleteLoanError) {

                    CustomToast.show(
                      message:
                      state.error
                          .orEmpty(),

                      type:
                      ToastType.error,
                    );
                  }
                },

                builder: (
                    context,
                    state,
                    ) {

                  final cubit =
                  LoanCubit.get(
                    context,
                  );

                  return CustomApiBuilderView(

                    isLoading:
                    state
                    is DeleteLoanLoading &&
                        state.id ==
                            request.id,

                    isError:
                    state
                    is DeleteLoanError,

                    showErrorView:
                    false,

                    showEmptyView:
                    false,

                    loadingWidget:
                    const LoaderWidget(
                      size: 40,
                    ),

                    contentBuilder:
                        () => deleteIcon(),

                    onRetry:
                        () => cubit
                        .deleteLoans(
                      request.id!,
                    ),

                    errorMessage:
                    state
                    is DeleteLoanError
                        ? state.error
                        : null,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// DELETE
  Widget deleteIcon() {

    return Builder(
      builder: (context) {

        return AppIcon(
          icon: Icon(
            Icons.delete,
            color:
            AppColors.primary,
          ),

          onTap: () {

            showAppOptionBottomSheet(

              context: context,

              title:
              "Are you sure you want to delete this request?"
                  .tr(),

              option1:
              BottomSheetOption(

                title:
                "Yes".tr(),

                backGroundColor:
                Colors.transparent,

                onTap: () {

                  context
                      .read<LoanCubit>()
                      .deleteLoans(
                    request.id!,
                  );

                  Navigator.pop(
                    context,
                  );
                },
              ),

              option2:
              BottomSheetOption(

                title:
                "No".tr(),

                backGroundColor:
                AppColors.primary,

                textColor:
                AppColors.white,

                onTap: () {

                  Navigator.pop(
                    context,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  /// UPDATE
  Widget updateIcon() {

    return Builder(
      builder: (context) {

        return AppIcon(

          icon: Icon(
            Icons.edit,
            color:
            AppColors.primary,
          ),

          onTap: () {

            showAppBottomSheet(

              context: context,

              title:
              'Update Loan Request'
                  .tr(),

              body: LoanRequestForm(

                request: request,

                buttonText:
                'Update Request'
                    .tr(),

                onSubmit: (
                    date,
                    amount,
                    loanType,
                    installments,
                    notes,
                    ) {

                  context
                      .read<LoanCubit>()
                      .updateLoans(

                    id: request.id!,

                    model: LoanRequest(

                      requestDate:
                      formatDateForApi(
                        date,
                      ),

                      amount:
                      amount,

                      loanType:
                      loanType,

                      installments:int.tryParse(
                      installments,
                      ),

                      notes:
                      notes,
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  String _formatDate(
      String? date,
      ) {

    if (date == null ||
        date.isEmpty) {

      return "--";
    }

    try {

      return dateFoemated(
        date,
      );

    } catch (e) {

      return "--";
    }
  }

  Widget _buildStatusChip(
      String? status,
      ) {

    Color color;

    String label;

    switch (status) {

      case "pending":

        color =
            AppColors.orange;

        label =
            'status_pending'
                .tr();

        break;

      case "approved":

        color =
            AppColors.mintGreen;

        label =
            'status_approved'
                .tr();

        break;

      case "rejected":

        color =
            AppColors.rose;

        label =
            'status_rejected'
                .tr();

        break;

      default:

        color =
            AppColors.orange;

        label =
            'status_pending'
                .tr();
    }

    return Container(

      padding:
      EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 0.6.h,
      ),

      decoration: BoxDecoration(

        color:
        color.withOpacity(
          MyApp.isDark
              ? 0.15
              : 0.1,
        ),

        borderRadius:
        BorderRadius.circular(
          10,
        ),
      ),

      child: Text(

        label,

        style:
        AppTextStyle
            .smallBody
            .copyWith(

          color: color,

          fontWeight:
          FontWeight.bold,
        ),
      ),
    );
  }

  String formatDateForApi(
      DateTime date,
      ) {

    return date
        .toString()
        .split(' ')
        .first;
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../ sheard/componnents/app_shimmers.dart';
import '../../../../ sheard/componnents/screen_builder/screen_builder.dart';
import '../../../../ sheard/componnents/show_app_toast.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_sized_box.dart';

import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/search_bar.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import '../../../../core/di/di.dart';

import '../../controller/my_mission_cubit.dart';
import '../../controller/my_mission_state.dart';
import '../widgets/mission_item_card.dart';

class MyMissionScreen extends StatelessWidget {
  const MyMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyMissionCubit>()..getAllMissions(),
      child: const _MyMissionView(),
    );
  }
}

class _MyMissionView extends StatefulWidget {
  const _MyMissionView();

  @override
  State<_MyMissionView> createState() => _MyMissionViewState();
}

class _MyMissionViewState extends State<_MyMissionView> {
  final scrollController=ScrollController();
  final searchController = TextEditingController();
  Timer? _debounce;
  int? _selectedStatusFilter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        MyMissionCubit.get(
          context,
        ).getAllMissions(loadMore: true);
      }
    });

  }

  String _getStatusLabel(int statusId) {
    switch (statusId) {
      case 1:
        return 'status_newTask'.tr();
      case 2:
        return 'status_progressing'.tr();
      case 3:
        return 'status_reviewing'.tr();
      case 4:
        return 'status_completed'.tr();
      default:
        return 'status_newTask'.tr();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyMissionCubit, MyMissionState>(
      listenWhen: (prev, current) =>
          current is UpdateMissionSuccess ||
          current is UpdateMissionError,
      listener: (context, state) {
        if (state is UpdateMissionSuccess) {
          CustomToast.show(message: "update_success".tr());
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: 'my_missions'.tr()),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              AppSearchBar(
                controller: searchController,
                onChange: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {});
                },
                onTapIconButton: () {
                  showAppBottomSheet(
                    context: context,
                    title: 'filter_by_status'.tr(),
                    body: Column(
                      children: [1, 2, 3, 4].map((statusId) {
                        final isSelected = _selectedStatusFilter == statusId;
                        return ListTile(
                          title: Text(_getStatusLabel(statusId)),
                          trailing: isSelected
                              ? const Icon(Icons.check, color: AppColors.primary)
                              : null,
                          onTap: () {
                            setState(() {
                              _selectedStatusFilter =
                                  isSelected ? null : statusId;
                            });
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
              AppSizedBox.h2,
              Expanded(
                child: BlocBuilder<MyMissionCubit, MyMissionState>(
                  buildWhen: (previous, current) =>
                      current is GetAllMissionsLoading ||
                      current is GetAllMissionsLoaded ||
                      current is GetAllMissionsError ||
                      current is PaginationLoading,
                  builder: (context, state) {
                    final cubit = MyMissionCubit.get(context);

                    // Apply filter
                    final filteredMissions = _selectedStatusFilter == null
                        ? cubit.missions
                        : cubit.missions
                            .where((m) => m.taskStatusId == _selectedStatusFilter)
                            .toList();

                    return RefreshIndicator(
                      onRefresh: () => cubit.getAllMissions(),
                      child: CustomApiBuilderView(
                        isLoading: state is GetAllMissionsLoading,
                        isError: state is GetAllMissionsError,
                        isEmpty: filteredMissions.isEmpty,
                        contentBuilder: () => Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: filteredMissions.length,
                                itemBuilder: (context, index) {
                                  return MyMissionItemCard(
                                    mission: filteredMissions[index],
                                  );
                                },
                              ),
                            ),
                            AppSizedBox.h1,
                            if (state is PaginationLoading)
                              const Center(child: LoaderWidget()),
                          ],
                        ),
                        loadingWidget: AppShimmer.verticalList(),
                        onRetry: () => cubit.getAllMissions(),
                        errorMessage: state is GetAllMissionsError
                            ? state.error
                            : null,
                        emptyTitle: "no_missions".tr(),
                        emptyDescription: "no_data".tr(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
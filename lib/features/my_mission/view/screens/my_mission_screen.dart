import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_sized_box.dart';

import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/empty_screen.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../ sheard/componnents/search_bar.dart';
import '../../../../ sheard/componnents/show_bottom_sheet.dart';
import 'package:hr_manegement/core/app_colors.dart';

import '../../data/models/mission_model.dart';
import '../../controller/mission_cubit.dart';
import '../../controller/mission_state.dart';
import '../widgets/mission_item_card.dart';

class MyMissionScreen extends StatefulWidget {
  const MyMissionScreen({super.key});

  @override
  State<MyMissionScreen> createState() => _MyMissionScreenState();
}

class _MyMissionScreenState extends State<MyMissionScreen> {
  var searchController = TextEditingController();
  Timer? _debounce;
  MissionStatus? _selectedFilter;

  String _getStatusLabel(MissionStatus status) {
    switch (status) {
      case MissionStatus.pending:
        return 'status_pending'.tr();
      case MissionStatus.approved:
        return 'status_approved'.tr();
      case MissionStatus.rejected:
        return 'status_rejected'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyMissionCubit()..loadMissions(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'my_missions'.tr()),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              AppSearchBar(
                controller: searchController,
                onChange: (value) {
                  if (_debounce?.isActive ?? false) {
                    _debounce!.cancel();
                  }
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    // هنا الفلتر يشتغل بعد ما المستخدم يوقف كتابة
                    print("Search value is $value");
                  });
                },
                onTapIconButton: () {
                  showAppBottomSheet(
                    context: context,
                    title: 'filter_by_status'.tr(),
                    body: Column(
                      children: MissionStatus.values.map((status) {
                        final isSelected = _selectedFilter == status;
                        return ListTile(
                          title: Text(_getStatusLabel(status)),
                          trailing: isSelected
                              ? const Icon(Icons.check, color: AppColors.primary)
                              : null,
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedFilter = null;
                              } else {
                                _selectedFilter = status;
                              }
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
                  builder: (context, state) {
                    if (state is MyMissionLoading) {
                      return const Center(child: LoaderWidget());
                    }

                    if (state is MyMissionEmpty) {
                      return EmptyScreen(
                        title: 'no_missions'.tr(),
                        description: 'no_missions_subtitle'.tr(),
                        image: AppAssets.appLogo,
                      );
                    }

                    if (state is MyMissionLoaded) {
                      final filteredMissions = _selectedFilter == null
                          ? state.missions
                          : state.missions
                              .where((m) => m.status == _selectedFilter)
                              .toList();

                      if (filteredMissions.isEmpty) {
                        return EmptyScreen(
                          title: 'no_missions'.tr(),
                          description: 'no_missions_subtitle'.tr(),
                          image: AppAssets.appLogo,
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () =>
                            context.read<MyMissionCubit>().loadMissions(),
                        child: ListView.builder(
                          itemCount: filteredMissions.length,
                          itemBuilder: (context, index) {
                            return TweenAnimationBuilder<double>(
                              duration: Duration(
                                milliseconds: 300 + (index * 100),
                              ),
                              tween: Tween(begin: 0.0, end: 1.0),
                              curve: Curves.easeIn,
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: Offset(0, 20 * (1 - value)),
                                    child: child,
                                  ),
                                );
                              },
                              child: MyMissionItemCard(
                                mission: filteredMissions[index],
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return const SizedBox();
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

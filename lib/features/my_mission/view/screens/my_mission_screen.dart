import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/app_sized_box.dart';
import 'package:hr_manegement/features/componnents/custom_app_bar.dart';
import 'package:hr_manegement/features/componnents/empty_screen.dart';
import 'package:hr_manegement/features/componnents/loading_widget.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_validation.dart';
import '../../../componnents/app_asset_image.dart';
import '../../../componnents/custom_text_field.dart';
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
              CustomTextField(
                hint: 'search_by_name'.tr(),
                type: TextInputType.text,
                controller: searchController,
                prefix: const AppAssetImage(
                  uri: AppAssets.search,
                  color: AppColors.primary,
                  fit: BoxFit.scaleDown,
                  width: 23,
                  height: 23,
                ),
                onChange: (value) {
                  if (_debounce?.isActive ?? false) {
                    _debounce!.cancel();
                  }
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    print("Search value is $value");
                  });
                },
                validator: Validations.noValidation,
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
                      return RefreshIndicator(
                        onRefresh: () =>
                            context.read<MyMissionCubit>().loadMissions(),
                        child: ListView.builder(
                          itemCount: state.missions.length,
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
                                mission: state.missions[index],
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

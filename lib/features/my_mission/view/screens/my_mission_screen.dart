import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/features/componnents/custom_app_bar.dart';
import 'package:hr_manegement/features/componnents/empty_screen.dart';
import 'package:hr_manegement/features/componnents/loading_widget.dart';

import '../../controller/mission_cubit.dart';
import '../../controller/mission_state.dart';
import '../widgets/mission_item_card.dart';

class MyMissionScreen extends StatelessWidget {
  const MyMissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyMissionCubit()..loadMissions(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'my_missions'.tr()),
        body: BlocBuilder<MyMissionCubit, MyMissionState>(
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
                onRefresh: () => context.read<MyMissionCubit>().loadMissions(),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  itemCount: state.missions.length,
                  itemBuilder: (context, index) {
                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 300 + (index * 100)),
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
                      child: MyMissionItemCard(mission: state.missions[index]),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

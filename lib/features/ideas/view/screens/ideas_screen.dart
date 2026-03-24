import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/features/componnents/custom_app_bar.dart';
import 'package:hr_manegement/features/componnents/empty_screen.dart';
import 'package:hr_manegement/features/componnents/loading_widget.dart';

import '../../controller/ideas_cubit.dart';
import '../../controller/ideas_state.dart';
import '../widgets/idea_request_card.dart';
import 'add_idea_screen.dart';

class IdeasScreen extends StatelessWidget {
  const IdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IdeasCubit()..loadIdeas(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'ideas'.tr()),
        body: BlocBuilder<IdeasCubit, IdeasState>(
          builder: (context, state) {
            if (state is IdeasLoading) {
              return const Center(child: LoaderWidget());
            }

            if (state is IdeasEmpty) {
              return EmptyScreen(
                title: 'no_ideas'.tr(),
                description: 'no_ideas_subtitle'.tr(),
                buttonText: 'add_idea'.tr(),
                image: AppAssets.appLogo,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BlocProvider.value(
                        value: IdeasCubit.get(context),
                        child: const AddIdeaScreen(),
                      ),
                    ),
                  );
                },
              );
            }

            if (state is IdeasLoaded) {
              return RefreshIndicator(
                onRefresh: () => context.read<IdeasCubit>().loadIdeas(),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  itemCount: state.ideas.length,
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
                      child: IdeaRequestCard(idea: state.ideas[index]),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
        floatingActionButton: BlocBuilder<IdeasCubit, IdeasState>(
          builder: (context, state) {
            if (state is IdeasLoaded) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => BlocProvider.value(
                        value: IdeasCubit.get(context),
                        child: const AddIdeaScreen(),
                      ),
                    ),
                  );
                },
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add, color: Colors.white),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../ sheard/componnents/app_asset_image.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../../../ sheard/componnents/custom_text_field.dart';
import '../../../../ sheard/componnents/empty_screen.dart';
import '../../../../ sheard/componnents/loading_widget.dart';
import '../../../../core/app_sized_box.dart';
import '../../../../core/app_validation.dart';

import '../../controller/ideas_cubit.dart';
import '../../controller/ideas_state.dart';
import '../widgets/idea_request_card.dart';
import 'add_idea_screen.dart';

class IdeasScreen extends StatefulWidget {
  const IdeasScreen({super.key});

  @override
  State<IdeasScreen> createState() => _IdeasScreenState();
}

class _IdeasScreenState extends State<IdeasScreen> {
  var searchController = TextEditingController();
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IdeasCubit()..loadIdeas(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'ideas'.tr()),
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
                child: BlocBuilder<IdeasCubit, IdeasState>(
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
                          itemCount: state.ideas.length,
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
                              child: IdeaRequestCard(idea: state.ideas[index]),
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

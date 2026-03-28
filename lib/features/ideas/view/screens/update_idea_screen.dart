import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/extensions.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../controller/ideas_cubit.dart';
import '../../controller/ideas_state.dart';
import '../../data/models/idea_model.dart';
import '../widgets/idea_request_form.dart';

class UpdateIdeaScreen extends StatelessWidget {
  final IdeaModel idea;
  const UpdateIdeaScreen({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'update_idea'.tr()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: BlocBuilder<IdeasCubit, IdeasState>(
          builder: (ctx, state) {
            return IdeaRequestForm(
              request: idea,
              buttonText: 'update_idea'.tr(),
              onSubmit:
                  ({
                    required date,
                    required ideaExplain,
                    required ideaLink,
                    ideaFile,
                    required type,
                  }) {
                    ctx.read<IdeasCubit>().updateIdea(
                      id: idea.id,
                      date: date,
                      ideaExplain: ideaExplain,
                      ideaLink: ideaLink,
                      ideaFile: ideaFile,
                      type: type,
                    );
                    Navigator.pop(context);
                  },
            );
          },
        ),
      ),
    );
  }
}

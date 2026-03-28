import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hr_manegement/core/extensions.dart';
import '../../../../ sheard/componnents/custom_app_bar.dart';
import '../../controller/ideas_cubit.dart';
import '../widgets/idea_request_form.dart';

class AddIdeaScreen extends StatelessWidget {
  const AddIdeaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'add_idea'.tr()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: IdeaRequestForm(
          onSubmit:
              ({
                required date,
                required ideaExplain,
                required ideaLink,
                ideaFile,
                required type,
              }) {
                IdeasCubit.get(context).addIdea(
                  date: date,
                  ideaExplain: ideaExplain,
                  ideaLink: ideaLink,
                  ideaFile: ideaFile,
                  type: type,
                );
                Navigator.pop(context);
              },
        ),
      ),
    );
  }
}

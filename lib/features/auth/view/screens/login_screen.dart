import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/features/main_screen/view/screens/main_screen.dart';

import '../../../../core/app_colors.dart';
import '../../../../my_app.dart';
import '../../../componnents/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(text: 'login'.tr(),
            width: 300,
            fontsize: 12,
            height: 50,
            butcolor: MyApp.isDark?AppColors.primary:AppColors.primary,
            radius: 12,
            onTap: (){
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                    (route) => false,
              );                  }),
          ),
    );
  }
}

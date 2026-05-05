import 'dart:async';
import 'package:hr_manegement/core/app_assets.dart';
import 'package:hr_manegement/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hr_manegement/data/storage/local/app_prefs.dart';

import '../../ sheard/componnents/app_asset_image.dart';
import '../../core/app_router.dart';
import '../../core/di/di.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() {
    timer = Timer(const Duration(seconds: 3), () async {
      if (ModalRoute.of(context)?.isCurrent == true) {
        if (getIt<AppPreferences>().isUserLogin) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.mainScreen,

            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: AlignmentDirectional.center,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: AppAssetImage(
            uri: AppAssets.appLogo,
            fit: BoxFit.scaleDown,
            height: 70.w,
            width: 70.w,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

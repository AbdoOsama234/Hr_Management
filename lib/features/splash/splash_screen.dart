// import 'dart:async';
// import 'package:hr_manegement/core/app_assets.dart';
// import 'package:hr_manegement/core/app_router.dart';
// import 'package:hr_manegement/core/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:hr_manegement/features/componnents/app_asset_image.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   Timer? timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _startDelay();
//   }
//
//   void _startDelay() {
//     timer = Timer(const Duration(seconds: 3), () async {
//       if (ModalRoute.of(context)?.isCurrent == true) {
//         Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           alignment: AlignmentDirectional.center,
//           padding: const EdgeInsets.symmetric(horizontal: 50),
//           child: AppAssetImage(
//             uri: AppAssets.loadingLogo,
//             fit: BoxFit.cover,
//             height: 50.h,
//             //width: double.infinity,
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }
// }

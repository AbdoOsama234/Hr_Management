// import 'dart:developer';
//
// import 'package:app_links/app_links.dart';
// import 'package:flutter/material.dart';
// import 'package:hr_manegement/my_app.dart';
//
// import '../../features/home/view/screens/car_details_page.dart';
// import '../app_router.dart';
//
// class DynamicLinkService {
//   late final AppLinks _appLinks;
//   Uri? _pendingUri;
//   Future<void> initDeepLinking() async {
//     _appLinks = AppLinks();
//
//     // Stream for when app is open
//     _appLinks.uriLinkStream.listen((Uri? uri) {
//       if (uri != null) {
//         log("initdeeplinking2");
//         _handleDeepLink(uri);
//       }
//     });
//
//     // Cold start
//     Uri? initialUri = await _appLinks.getInitialLink();
//     if (initialUri != null) {
//       log("initdeeplinking3");
//       _handleDeepLink(initialUri, coldStart: true);
//     }
//   }
//
//   void _handleDeepLink(Uri uri, {bool coldStart = false}) {
//     log("initdeeplinking4");
//     log("Received deep link: $uri");
//
//     _pendingUri = uri;
//
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       log("initdeeplinking5");
//       await _navigateToDeepLink(coldStart: coldStart);
//     });
//   }
//
//   Future<void> _navigateToDeepLink({bool coldStart = false}) async {
//     log("initdeeplinking6");
//     if (_pendingUri == null) return;
//     log("initdeeplinking7");
//     final uri = _pendingUri!;
//     _pendingUri = null;
//     log("initdeeplinking8");
//     // if (SharedPreferenceHelper.loadUserData().userID == null) {
//     //   log("initdeeplinking9");
//     //   navigatorKey.currentState?.pushReplacementNamed(RouteManager.loginScreen);
//     // } else {
//     log("initdeeplinking10");
//     await goToSpasifcPage(uri, coldStart: coldStart);
//     //}
//   }
//
//   Future<void> goToSpasifcPage(Uri uri, {bool coldStart = false}) async {
//     log("initdeeplinking13");
//     if (uri.pathSegments.length >= 2 && uri.pathSegments[0] == 'car') {
//       final id = uri.pathSegments[1];
//       log("Test Deep Linking 7");
//       log("ID: $id");
//
//       //post work
//       if (id.isNotEmpty) {
//         log("Navigating to PostScreen with productId: $id");
//         await navigatorKey.currentState?.push(
//           MaterialPageRoute(builder: (context) => CarDetailsPage(carId: id)),
//         );
//         await goToMainScreen(navigatorKey.currentState!.context);
//         //Group work
//       }
//     }
//   }
//
//   Future<void> goToMainScreen(BuildContext context) async {
//     log("initdeeplinking15");
//     // if (SharedPreferenceHelper.loadUserData().userID != null) {
//     //   log("initdeeplinking17");
//     //   await Navigator.pushReplacementNamed(
//     //       context, RouteManager.templateFoodScreen);
//     // } else {
//     log("initdeeplinking18");
//     await Navigator.pushReplacementNamed(context, Routes.mainScreen);
//     //}
//     log("initdeeplinking19");
//   }
// }

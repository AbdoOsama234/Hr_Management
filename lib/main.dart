import 'dart:io';

import 'package:easy_localization/easy_localization.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hr_manegement/core/constants.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/firebase_options.dart';
import 'core/bloc_observer.dart';
import 'core/helpers/background_tracking_services.dart';
import 'core/helpers/fire_base/firebase_notification.dart';
import 'data/storage/local/app_prefs.dart';
import 'my_app.dart';

void main() async {
  print("Platform.localeName : ${Platform.localeName[0]}");
  //By default, the splash screen will be removed when Flutter has drawn the first frame.
  // If you would like the splash screen to remain while your app initializes,
  // you can use the preserve() and remove() methods together.
  // Pass the preserve() method the value returned from WidgetsFlutterBinding.
  //ensureInitialized() to keep the splash on screen. Later,
  //when your app has initialized, make a call to remove() to remove the splash screen.
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService notificationService = NotificationService.instance;
  notificationService.initialize();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(const Duration(milliseconds: 500), () {
    FlutterNativeSplash.remove();
  });
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await EasyLocalization.ensureInitialized();
  //BlocObserver must be set before any Bloc is created
  //it must be before this: await configureDependencies();
  Bloc.observer = MyBlocObserver();
  //start for background tracking
  await BackgroundTrackingManager.init();
  await configureDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: Constants.supportedLocales,
      path: Constants.translationsPath,
      fallbackLocale: const Locale(Constants.defaultLanguage),
      startLocale: Locale(getIt<AppPreferences>().lang),
      child: const MyApp(),
    ),
  );
}

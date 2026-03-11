import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hr_manegement/core/app_cubit/app_state.dart';
import 'package:hr_manegement/core/di/di.dart';
import 'package:hr_manegement/core/di/module/dio_module.dart';
import 'package:hr_manegement/my_app.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants.dart';
import '../storage/local/app_prefs.dart';

@singleton
class AppCubit extends Cubit<AppState> {
  final AppPreferences appPreferences;
  late Locale locale;
  late bool isDark;
  String currentFont = Constants.enLanguage;

  AppCubit(this.appPreferences) : super(AppInitial()) {
    isDark = appPreferences.isDarkMode;
    locale = Locale(appPreferences.lang);
    currentFont = locale.languageCode == Constants.arLanguage
        ? Constants.arFont
        : Constants.enFont;
    log(locale.languageCode);
    log('new lang in  AppCubit init  is ${locale.languageCode}');
    log('new theme in  AppCubit init  is $isDark');
    log('new font in  AppCubit init  is $currentFont');
  }

  static AppCubit get(BuildContext context) => context.read<AppCubit>();

  bool get isArSelected => locale.languageCode == Constants.arLanguage;

  void changeLang(String lang) {
    emit(LoadingChangeLanguage());
    locale = Locale(lang);
    appPreferences.lang = locale.languageCode;
    appPreferences.isLanguageSelected = true;
    MyApp.appContext.setLocale(locale);
    getIt<Dio>().updateHeader(appPreferences);
    log('new lang in  AppCubit is ${locale.languageCode}');
    updateFont(locale);
    emit(ChangeLanguage());
  }

  void changeDateMethod(String dateMethod) {
    if (dateMethod == Constants.hijriDate) {
      appPreferences.dateMethod = Constants.hijriDate;
    } else {
      appPreferences.dateMethod = Constants.gregorianDate;
    }
    emit(ChangeLanguage());
  }

  void changeTheme({bool? isDark}) {
    emit(LoadingChangeTheme());
    this.isDark = isDark ?? !this.isDark;
    appPreferences.isDarkMode = this.isDark;
    log('new theme in  AppCubit is ${this.isDark}');
    emit(ChangeTheme());
  }

  void updateFont(Locale locale) {
    emit(LoadingChangeFontTheme());
    if (locale.languageCode == Constants.arLanguage) {
      currentFont = Constants.arFont;
    } else {
      currentFont = Constants.enFont;
    }
    appPreferences.font = currentFont;
    log('new font in  AppCubit is $currentFont');
    emit(ChangeFontTheme());
  }
}

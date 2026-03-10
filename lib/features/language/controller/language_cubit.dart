import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_manegement/core/constants.dart';
import 'package:hr_manegement/data/storage/local/app_prefs.dart';
import 'package:hr_manegement/features/language/controller/language_state.dart';
import 'package:hr_manegement/my_app.dart';
import 'package:injectable/injectable.dart';

@singleton
class LanguageCubit extends Cubit<LanguageState> {
  final AppPreferences _appPreferences;

  LanguageCubit(this._appPreferences)
    : super(
        LanguageInitial(
          Locale(_appPreferences.lang),
          _appPreferences.lang == Constants.arLanguage
              ? Constants.arFont
              : Constants.enFont,
        ),
      );

  void changeLanguage() {
    final String currentLang = state.locale.languageCode;
    final String newLang = currentLang == Constants.arLanguage
        ? Constants.enLanguage
        : Constants.arLanguage;

    final String newFont = newLang == Constants.arLanguage
        ? Constants.arFont
        : Constants.enFont;

    final Locale newLocale = Locale(newLang);

    // Persist changes
    _appPreferences.lang = newLang;
    _appPreferences.font = newFont;

    // Update EasyLocalization
    MyApp.appContext.setLocale(newLocale);

    emit(LanguageChanged(newLocale, newFont));
  }

  bool get isArabic => state.locale.languageCode == Constants.arLanguage;
}

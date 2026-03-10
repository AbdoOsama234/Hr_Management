import 'package:flutter/material.dart';

@immutable
abstract class LanguageState {
  final Locale locale;
  final String fontFamily;

  const LanguageState(this.locale, this.fontFamily);
}

class LanguageInitial extends LanguageState {
  const LanguageInitial(super.locale, super.fontFamily);
}

class LanguageChanged extends LanguageState {
  const LanguageChanged(super.locale, super.fontFamily);
}

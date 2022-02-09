import 'package:app_localization/src/localization/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LocaleConfig {
  static List<Locale> supportedLocales = [
    const Locale('en', ''),
    const Locale('he', ''),
    const Locale('fr', ''),
    const Locale('hi', ''),
  ];

  static List<LocalizationsDelegate> localizationsDelegates = [
    LocalizationDelegate(),
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate
  ];
}
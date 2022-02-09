import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  static final Map<String, Map<String, String>> _localizedValues = {};

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) =>
      Localizations.of(context, AppLocalizations);

  Future<void> load() async {
    String data = await rootBundle
        .loadString('resources/lang/${locale.languageCode}.json');
    Map<String, dynamic> _result = json.decode(data);

    Map<String, String> _values = {};
    _result.forEach((key, value) {
      _values[key] = value.toString();
    });
    _localizedValues[locale.languageCode] = _values;
  }

  String find(String key) => _localizedValues[locale.languageCode]?[key] ?? '';
}

import 'package:app_localization/src/config/locale_config.dart';
import 'package:app_localization/src/pages/login_page.dart';
import 'package:app_localization/src/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'src/localization/index.dart';
import 'src/navigation_service.dart';

void main() {
  runApp(const LocalizationApp());
}

class LocalizationApp extends StatelessWidget {
  const LocalizationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localization App',
      navigatorKey: NavigationService.navigatorKey,
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)!.find('app_title'),
      localizationsDelegates: LocaleConfig.localizationsDelegates,
      supportedLocales: LocaleConfig.supportedLocales,
      home: const SplashPage(),
    );
  }
}

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/presentation/routing/router.dart';
import 'package:weather_app/presentation/style/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    updateThemeColors(MediaQuery.platformBrightnessOf(context));
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      updateThemeColors(MediaQuery.platformBrightnessOf(context));
    };

    return MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
  }
}

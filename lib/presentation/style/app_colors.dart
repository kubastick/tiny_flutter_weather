import 'dart:ui';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

BehaviorSubject<AppThemeColors> _appThemeColorSubject = BehaviorSubject();

// TODO: Support separate dart/white themes
void updateThemeColors(Brightness brightness) {
  switch (brightness) {
    case Brightness.dark:
      _appThemeColorSubject.sink.add(AppColorsDark());
      break;
    case Brightness.light:
      _appThemeColorSubject.sink.add(AppColorsDark());
      break;
  }
}

class AppColors {
  static const darkOpacity15 = Color.fromARGB(38, 0, 0, 0);
  static const transparentWhite = Color.fromARGB(220, 255, 255, 255);
}

abstract class AppThemeColors {
  Color get blurredTileBackgroundTint;

  Color get primaryContent;
}

class AppColorsDark implements AppThemeColors {
  @override
  Color get blurredTileBackgroundTint => AppColors.darkOpacity15;

  @override
  Color get primaryContent => AppColors.transparentWhite;
}

AppThemeColors useAppThemeColors() {
  final appThemeColors = useStream(_appThemeColorSubject).data ?? _appThemeColorSubject.value;

  return appThemeColors;
}

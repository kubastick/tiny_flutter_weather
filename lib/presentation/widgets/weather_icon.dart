import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/domain/weather/models/icon_type.dart';
import 'package:weather_app/presentation/style/app_colors.dart';
import 'package:weather_app/presentation/style/app_dimens.dart';
import 'package:weather_app/presentation/style/app_icons.dart';

class WeatherIcon extends HookWidget {
  const WeatherIcon({
    required this.iconType,
    this.height = AppDimens.m,
    this.width = AppDimens.m,
    this.color,
    Key? key,
  }) : super(key: key);

  final IconType iconType;
  final double height;
  final double width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = useAppThemeColors();
    return SvgPicture.asset(
      _iconPath,
      width: width,
      height: height,
      color: color ?? colors.primaryContent,
    );
  }

  String get _iconPath {
    switch (iconType) {
      case IconType.cloud:
        return AppIcons.clouds;
      case IconType.rain:
        return AppIcons.rain;
      case IconType.sun:
        return AppIcons.sun;
    }
  }
}

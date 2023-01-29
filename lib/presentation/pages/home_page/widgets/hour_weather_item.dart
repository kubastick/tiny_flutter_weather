import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/weather/models/conditions.dart';
import 'package:weather_app/presentation/style/app_colors.dart';
import 'package:weather_app/presentation/style/app_dimens.dart';
import 'package:weather_app/presentation/widgets/weather_icon.dart';

final _elementDateFormat = DateFormat("H");

class HourWeatherItem extends HookWidget {
  const HourWeatherItem({
    required this.conditions,
    required this.isFirst,
    Key? key,
  }) : super(key: key);

  final Conditions conditions;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final appColors = useAppThemeColors();

    return Column(
      children: [
        Text(
          isFirst ? "Now" : _elementDateFormat.format(conditions.date),
          style: GoogleFonts.poppins(color: appColors.primaryContent, fontSize: 17),
        ),
        const SizedBox(height: AppDimens.s),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WeatherIcon(
              iconType: conditions.icon,
              height: AppDimens.m,
              width: AppDimens.sm,
            ),
            const SizedBox(width: AppDimens.xs),
            Text(
              "${conditions.temp.floor().toString()}°",
              style: GoogleFonts.poppins(color: appColors.primaryContent, fontSize: 17),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/weather/models/conditions.dart';
import 'package:weather_app/presentation/style/app_colors.dart';
import 'package:weather_app/presentation/style/app_dimens.dart';
import 'package:weather_app/presentation/widgets/weather_icon.dart';

final _dateFormat = DateFormat("EEEE");

class WeekWeatherItem extends HookWidget {
  const WeekWeatherItem({
    required this.conditions,
    Key? key,
  }) : super(key: key);

  final Conditions conditions;

  @override
  Widget build(BuildContext context) {
    final colors = useAppThemeColors();

    return Row(
      children: [
        Text(
          _dateFormat.format(conditions.date),
          style: GoogleFonts.poppins(
            color: colors.primaryContent,
            fontSize: 17,
          ),
        ),
        const Expanded(child: SizedBox()),
        WeatherIcon(iconType: conditions.icon),
        SizedBox(
          width: AppDimens.xl,
          child: Text(
            conditions.temp.floor().toString(),
            style: GoogleFonts.poppins(
              color: colors.primaryContent,
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

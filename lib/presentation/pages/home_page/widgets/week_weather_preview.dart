import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/domain/weather/models/conditions.dart';
import 'package:weather_app/presentation/pages/home_page/widgets/week_weather_item.dart';
import 'package:weather_app/presentation/style/app_colors.dart';
import 'package:weather_app/presentation/style/app_dimens.dart';
import 'package:weather_app/presentation/widgets/preview_tile.dart';

class WeekWeatherPreview extends HookWidget {
  const WeekWeatherPreview({
    required this.conditions,
    Key? key,
  }) : super(key: key);

  final List<Conditions> conditions;

  @override
  Widget build(BuildContext context) {
    final colors = useAppThemeColors();

    return PreviewTile(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.l,
          vertical: AppDimens.s,
        ),
        child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, i) => WeekWeatherItem(
            conditions: conditions[i],
          ),
          separatorBuilder: (context, i) => Divider(color: colors.primaryContent),
          itemCount: conditions.length,
        ),
      ),
    );
  }
}

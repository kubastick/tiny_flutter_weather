import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/domain/weather/models/conditions.dart';
import 'package:weather_app/presentation/pages/home_page/widgets/hour_weather_item.dart';
import 'package:weather_app/presentation/style/app_colors.dart';
import 'package:weather_app/presentation/style/app_dimens.dart';
import 'package:weather_app/presentation/widgets/preview_tile.dart';

class HourWeatherPreview extends HookWidget {
  const HourWeatherPreview({
    required this.hourConditionRows,
    Key? key,
  }) : super(key: key);

  final List<List<Conditions>> hourConditionRows;

  @override
  Widget build(BuildContext context) {
    final appColors = useAppThemeColors();

    return PreviewTile(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
        child: ListView.separated(
          itemBuilder: (context, i) => _HourRow(
            hourConditions: hourConditionRows[i],
            isFirst: i == 0,
          ),
          separatorBuilder: (context, i) => Divider(color: appColors.primaryContent),
          itemCount: hourConditionRows.length,
          primary: false,
          shrinkWrap: true,
        ),
      ),
    );
  }
}

class _HourRow extends StatelessWidget {
  const _HourRow({
    Key? key,
    required this.hourConditions,
    required this.isFirst,
  }) : super(key: key);

  final List<Conditions> hourConditions;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: hourConditions
          .map(
            (conditions) => HourWeatherItem(
              conditions: conditions,
              isFirst: hourConditions.indexOf(conditions) == 0 && isFirst,
            ),
          )
          .toList(),
    );
  }
}

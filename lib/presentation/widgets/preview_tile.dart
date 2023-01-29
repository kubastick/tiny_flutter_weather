import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:weather_app/presentation/style/app_colors.dart';
import 'package:weather_app/presentation/style/app_dimens.dart';

const _blurAmount = 100.0;

class PreviewTile extends HookWidget {
  const PreviewTile({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = useAppThemeColors();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.previewTileBorderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: _blurAmount,
          sigmaY: _blurAmount,
        ),
        child: Container(
          padding: const EdgeInsets.all(AppDimens.s),
          decoration: BoxDecoration(
            color: colors.blurredTileBackgroundTint,
          ),
          child: child,
        ),
      ),
    );
  }
}

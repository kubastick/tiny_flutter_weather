import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:weather_app/generated/locale_keys.g.dart';
import 'package:weather_app/presentation/pages/home_page/home_page_cubit.dart';
import 'package:weather_app/presentation/pages/home_page/widgets/hour_weather_preview.dart';
import 'package:weather_app/presentation/pages/home_page/widgets/week_weather_preview.dart';
import 'package:weather_app/presentation/routing/router.dart';
import 'package:weather_app/presentation/style/app_colors.dart';
import 'package:weather_app/presentation/style/app_dimens.dart';
import 'package:weather_app/presentation/style/app_icons.dart';
import 'package:weather_app/presentation/widgets/preview_tile.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = useAppThemeColors();
    final cubit = useBloc<HomePageCubit>();
    final state = useBlocBuilder(cubit);

    useEffect(
      () {
        cubit.initialize();

        return null;
      },
      [cubit],
    );

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppIcons.backgroundCloudy3),
            fit: BoxFit.cover,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          child: state.map(
            initial: (_) => const SizedBox.expand(),
            loading: (_) => const Center(
              child: CupertinoActivityIndicator(),
            ),
            idle: (state) => SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
              child: SafeArea(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => SelectCityPageRoute().go(context),
                      child: PreviewTile(
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.location_solid,
                              color: colors.primaryContent,
                            ),
                            const SizedBox(width: AppDimens.s),
                            Text(
                              state.currentCityName,
                              style: GoogleFonts.poppins(
                                color: colors.primaryContent,
                                fontSize: 20,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            Icon(
                              Icons.edit,
                              color: colors.primaryContent,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimens.xxl),
                    PreviewTile(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.home_page_today.tr(),
                                style: GoogleFonts.poppins(
                                  color: colors.primaryContent,
                                  fontSize: 20,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: colors.primaryContent,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppIcons.clouds,
                                width: 73,
                                height: 55,
                                color: colors.primaryContent,
                              ),
                              const SizedBox(width: AppDimens.m),
                              Text(
                                "${state.currentConditions.temp.floor()}°",
                                style: GoogleFonts.poppins(
                                  color: colors.primaryContent,
                                  fontSize: 77,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: AppDimens.l),
                          // TODO: Weather type string
                          Text(
                            "Cloudy",
                            style: GoogleFonts.poppins(
                              color: colors.primaryContent,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimens.l),
                    HourWeatherPreview(
                      hourConditionRows: state.nextHourConditionRows,
                    ),
                    const SizedBox(height: AppDimens.l),
                    WeekWeatherPreview(
                      conditions: state.nextDaysConditions,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

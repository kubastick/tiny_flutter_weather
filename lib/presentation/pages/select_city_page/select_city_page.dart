import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:weather_app/generated/locale_keys.g.dart';
import 'package:weather_app/presentation/pages/select_city_page/select_city_page_cubit.dart';
import 'package:weather_app/presentation/style/app_dimens.dart';

class SelectCityPage extends HookWidget {
  const SelectCityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<SelectCityPageCubit>();
    final state = useBlocBuilder(cubit);

    useBlocListener<SelectCityPageCubit, SelectCityPageState>(
      cubit,
      (cubit, state, context) {
        state.mapOrNull(
          done: (_) => GoRouter.of(context).pop(),
        );
      },
    );

    useEffect(
      () {
        cubit.initialize();

        return null;
      },
      [cubit],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.select_city_page_title.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.s),
        child: state.maybeMap(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          idle: (state) => Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(AppDimens.ll)),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  hintText: LocaleKeys.select_city_page_type_city_name_here_hint.tr(),
                ),
                onChanged: cubit.onCitySearchFieldUpdated,
              ),
              const SizedBox(height: AppDimens.s),
              Expanded(
                child: Stack(
                  children: [
                    ListView.builder(
                      itemCount: state.places.length,
                      itemBuilder: (context, i) {
                        final place = state.places[i];

                        return ListTile(
                          title: Text(place.name),
                          onTap: () => cubit.onPlaceSelected(place),
                        );
                      },
                    ),
                    if (state.showPlacesLoader)
                      const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                  ],
                ),
              ),
            ],
          ),
          orElse: () => const SizedBox.shrink(),
        ),
      ),
    );
  }
}

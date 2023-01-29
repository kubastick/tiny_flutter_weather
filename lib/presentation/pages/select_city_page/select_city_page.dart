import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
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
        title: const Text("Select city"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.s),
        child: state.maybeMap(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          idle: (state) => Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(AppDimens.ll)),
                  ),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Type city name here...",
                ),
                onChanged: cubit.onCitySearchFieldUpdated,
              ),
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

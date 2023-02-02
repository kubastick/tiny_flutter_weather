import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/presentation/pages/home_page/home_page.dart';
import 'package:weather_app/presentation/pages/select_city_page/select_city_page.dart';

part 'router.g.dart';

final router = GoRouter(routes: $appRoutes);

@TypedGoRoute<HomeRoute>(
  path: "/",
  routes: <TypedGoRoute>[
    TypedGoRoute<SelectCityPageRoute>(
      path: "select_city",
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}

class SelectCityPageRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) => const SelectCityPage();
}

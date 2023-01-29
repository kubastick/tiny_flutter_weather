import 'package:injectable/injectable.dart';
import 'package:weather_app/core/env/app_config.dart';

@module
abstract class ConfigModule {
  AppConfig get appConfig => AppConfig.fromEnvironment();
}

class AppConfig {
  const AppConfig._({
    required this.googlePlacesApiKey,
    required this.visualCrossingApiKey,
  });

  final String googlePlacesApiKey;
  final String visualCrossingApiKey;

  factory AppConfig.fromEnvironment() {
    return const AppConfig._(
      googlePlacesApiKey: String.fromEnvironment("PLACES_API_KEY"),
      visualCrossingApiKey: String.fromEnvironment("VS_CROSSING_API_KEY"),
    );
  }
}

# Tiny flutter weather - WIP

Tiny weather app created using flutter.  

![Screenshot of the app displaying the main screen, showing the weather in Warsaw, Poland](/artwork/screenshot-1.png?raw=true)

This app uses a clean architecture along with BLoC and RxDart for state management.

## Getting Started

To build and run this app you will have to obtain [VisualCrossing Weather](https://www.visualcrossing.com) and [Google Places](https://developers.google.com/maps/documentation/places/web-service/overview) API Keys.  
Both APIs are free of charge for personal use.

```
# Download dependencies
flutter pub get

# Run code generation
flutter pub run build_runner build --delete-conflicting-outputs

# Generate translations
flutter pub run easy_localization:generate -S ./assets/translations -f keys -o locale_keys.g.dart

# Build&run app 
flutter run --dart-define="PLACES_API_KEY=<INSERT_GOOGLE_PLACES_API_KEY_HERE>" --dart-define="VS_CROSSING_API_KEY=<INSERT_VISUAL_CROSSING_API_KEY_HERE>"
```

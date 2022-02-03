Build a production version for Android
```CODE
flutter build apk -v
```
To build a production version for Android but sill see logs to in terminal
```CODE
flutter run -d android --release
```
# Project structure
- assets folder
    - fonts
    - images
- lib folder
    - config
        - theme
            - colors.dart
            - custom_theme.dart
    - routes
        - routes.dart
        - routes_desktop.config.dart
        - routes_handler.dart
        - routes_mobile_config.dart
    - constants
        - app_constants.dart
        - asset_path.dart
    - views
        - desktop

          UI code for desktop (Linux, Windows, and Mac)
        - mobile

          UI code for mobile (Android)
        - shared

          Mobile-Desktop shared code (Not UI)
        - widgets

          Mobile-Desktop shared UI widgets.
- test
- pubspec.yaml

  Contains packages and metadata about the project that the Dart and Flutter tooling needs to know. 
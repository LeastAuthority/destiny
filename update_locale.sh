#!/usr/bin/env sh

flutter pub run easy_localization:generate -S ./assets/translations 
flutter pub run easy_localization:generate -S ./assets/translations -f keys -o locale_keys.g.dart

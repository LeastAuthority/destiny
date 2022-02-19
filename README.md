# Cross-platform Magic Wormhole graphical client

⚠ This project is still a work in progress, use at your own risk ⚠

Easily send and receive files without signup or loss of privacy. Based on the
[wormhole-william](https://github.com/LeastAuthority/wormhole-william)
implementation of the [Magic Wormhole protocol](https://github.com/magic-wormhole/magic-wormhole).
This application relies on a plugin that wraps the wormhole-william client
with a Dart API. The plugin is implemented [here](https://github.com/LeastAuthority/dart_wormhole_william).

Supported platforms

- [x] Linux
- [x] Android
- [ ] Windows
- [ ] OSX

## Building

### Dependencies

- Go >= 1.12
- Flutter >= 2.10.1
- Android SDK for Android builds

### Unsigned release builds

Linux:

```bash
flutter build linux -v
```

Android:

```bash
flutter build apk -v
```

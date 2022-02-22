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

Builds for magic-wormhole.io:

```bash
flutter build linux
flutter build apk
```

Builds for Least Authority servers:

```bash
flutter build linux lib/main_la.dart
flutter build apk lib/main_la.dart
```

Builds for local instances:

```bash
flutter build linux lib/main_local.dart
```

## Usage with `wormhole-william`

Send a file:

```bash
wormhole-william send <file_path>
```

Receive a file:

```bash
wormhole-william receive 33-leprosy-highchair
```

Transferring files with leastauthority.com

```bash
wormhole-william receive --relay-url="wss://mailbox.w.leastauthority.com/v1" --transit-helper="tcp:relay.w.leastauthority.com:443" 33-leprosy-highchair
```

Transferring files with a local backend

```bash
wormhole-william receive --relay-url="ws://0.0.0.0:4000/v1" --transit-helper="tcp:0.0.0.0:4001" 33-leprosy-highchair
```

### Starting the wormhole services locally

```bash
cd docker
docker-compose up -d
```

 Known Issues:
Flutter currently [does not support x86 for android builds](https://github.com/flutter/flutter/issues/9253),
so x86 emulators or devices are not supported.

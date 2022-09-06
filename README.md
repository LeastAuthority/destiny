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
- [x] Windows
- [x] OSX

## Cloning

```bash
git clone git@github.com:LeastAuthority/flutter_wormhole_gui.git
git submodule init
git submodule update --recursive
```
or you can do it in one step:

```bash
git clone --recurse-submodules git@github.com:LeastAuthority/flutter_wormhole_gui.git
```

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
flutter build appbundle
flutter build macos
```

Builds for Least Authority servers:

```bash
flutter build linux lib/main_la.dart
```

Builds for local instances:

```bash
flutter build linux lib/main_local.dart
```

## Signing Android AppBundle for Google Play upload
Improtant! First time upload key is used for signing further builds. Key should be shared with other developers if more then one person is signing app

Developer upload key is necessary for upload AppBundle to store. Find out [more](https://support.google.com/googleplay/android-developer/answer/9842756?hl=en#zippy=%2Cupload-key-requirements)
1. Generate upload key with keytool (Note! store keystore.jks file outside project dir)
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload-key
```
2. Create key.properties file and add your details (Note! key.properties should outside project dir and not be pushed to repo)
```bash
KEY_ALIAS=upload-key
KEY_PASSWORD=<password>
STORE_FILE=/Users/<my_user>/upload-keystore.jks
STORE_PASSWORDP=<password>
```
3. Set key.properties path in gradle.properties file for parameter AndroidProject.signing=/your/path/key.properties
4. Run build manually
```bash
flutter build appbundle --build-name=<build_version> --dart-define version=<build_version> --build-number=<build_number> -t lib/main_la.dart
```
Note: Google Play store requires unique or incremental build-number for every upload to store.

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
wormhole-william receive --relay-url="wss://mailbox.w.leastauthority.com/v1" --transit-helper="wss://relay.w.leastauthority.com:443" 33-leprosy-highchair
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

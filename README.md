<h1 align="center">
  <img src="https://github.com/LeastAuthority/destiny/raw/main/assets/images/intro-logo.png" height="150" alt="Destiny">
</h1>

# Cross-platform Magic Wormhole graphical client

## An end-to-end encrypted app to share files without revealing your identity 

Destiny is a secure file transfer application that allows people to transfer files without needing to reveal their identities to each other or the service provider. All files are end-to-end encrypted, meaning no one except the sender and the receiver can decrypt the contents. Users select a file on their device and then share the generated code with the intended recipient for safe delivery. No sign-up is needed.

Key security features:

- **Identity-less**: no need to disclose identity information (such as name, email address, or phone number) to be able to transfer files.
- **End-to-end encryption**: files are end-to-end encrypted and only the sender and recipient can read them.
- **Peer-to-peer** file sharing: Destiny attempts to make a direct network connection to the other party. If both parties are on the same local network they should connect without any traffic leaving that network, for example. When this isn’t possible (e.g. if neither party has a public IP address) then our relay server is used (however, that server sees only encrypted packets).
- **Full-strength keys**: although our codes are short and human-memorable, they are part of an online “Password Authenticated Key Exchange” (PAKE) which only allows a single guess – and yields a 256-bit full-strength symmetric key.


Based on the [wormhole-william](https://github.com/LeastAuthority/wormhole-william)
implementation of the [Magic Wormhole protocol](https://github.com/magic-wormhole/magic-wormhole).
This application relies on [a plugin that wraps the wormhole-william client](https://github.com/LeastAuthority/dart_wormhole_william)
with a Dart API.

Supported platforms

- [x] Linux (amd64)
- [x] Windows
- [x] macOS
- [x] Android (Google Play & F-Droid)
- [x] iOS


## Usage

### Installation

You can find detailed instructions on how to install applications on various [platforms](https://github.com/LeastAuthority/destiny/blob/main/docs/installation.md)

[Windows](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_windows.msix), [Linux](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_linux_amd64.AppImage), [macOS](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_macos.dmg) files can be downloaded from the latest [release](https://github.com/LeastAuthority/destiny/releases/latest).

Available on external stores:

[<img src="assets/images/google-play-store-label.png" height="40" alt="Google Play store">](https://play.google.com/store/apps/details?id=com.leastauthority.destiny)
[<img src="assets/images/f-droid-store-label.png" height="40" alt="F-Droid  store">](https://f-droid.org/en/packages/com.leastauthority.destiny/)
[<img src="assets/images/apple-store-label.png" height="40" alt="App store">](https://apps.apple.com/us/app/destiny-secure-file-transfer/id6444721954)

Alternatively, apps can be downloaded directly from GitHub release [assets](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_android.apk) and installed manually.


### Verification

We recommend [verifying every downloaded file](https://github.com/LeastAuthority/destiny/blob/main/docs/releases.md) against the corresponding signature.

### Please check our [**FAQ**](https://github.com/LeastAuthority/destiny/blob/main/FAQ.md), [**Privacy Policy**](https://github.com/LeastAuthority/destiny/blob/main/PRIVACY-POLICY.md) and [**Terms & Conditions**](https://github.com/LeastAuthority/destiny/blob/main/TERMS.md) to find more information before using applications.


## Cloning

```bash
git clone --recurse-submodules git@github.com:LeastAuthority/destiny.git
```

## Building

### Dependencies

- Go >= 1.19
- Flutter >= 3.0.0
- Android SDK for Android builds (>= SDK 24)

### Unsigned release builds

Builds for magic-wormhole.io by default:

```bash
flutter build linux
flutter build apk
flutter build appbundle
flutter build macos
flutter build ipa
```

Builds for Least Authority servers:

```bash
flutter build linux -t lib/main_la.dart
```

Builds for local instances:


```bash
flutter build linux -t lib/main_local.dart
```

Checkout detailed instructions for [building](https://github.com/LeastAuthority/destiny/blob/main/docs/building.md).

If flutter is not used for web application, worth to set to avoid additional files generation and static analysis warnings:
```bash
flutter config --no-enable-web
```

Checkout detailed instructions on how to [sign](https://github.com/LeastAuthority/destiny/blob/main/docs/releases.md) releases](https://github.com/LeastAuthority/destiny/blob/main/docs/releases.md).


### i18n & l10n

For translation and localization we use the [Easy Localization](https://pub.dev/packages/easy_localization) plugin.

To regenerate configuration and key classes please run
```shell script
./update_locale.sh
```

### Starting the wormhole services locally

```bash
cd docker
docker-compose up -d
```

## Known Issues:
- Flutter currently [does not support x86 for android builds](https://github.com/flutter/flutter/issues/9253),
so x86 emulators or devices are not supported.
- MacOS M1/M2 (arm64) chip build is not supported yet.

### Other configuration/ notes

- To disable debug label on the app in the emulator, set debugShowCheckedModeBanner: false (two places)

- iOS downloaded files are stored in the app/Documents folder, which is displayed in Files App as a dedicated application folder. If Files doesn't display the application folder, try restarting the phone.
Note, that if the App is deleted, all downloaded files in the same App folder will be deleted too.

- Delete default settings:
  - for macOS: `defaults delete com.leastauthority.destiny`

# Signing releases and verification

## Android AppBundle for Google Play upload
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


## iOS bundle upload to App Store

To build for production, use command:
```bash
flutter build ipa --build-name=<version> --dart-define version=v<version> -t lib/main_la.dart --release
```

Prerequisite: Apple Developer account is mandatory

Validate
```bash
xcrun altool --validate-app -f build/ios/ipa/Destiny.ipa -t ios -u <username> -p <app passowd>
```
Upload
```bash
xcrun altool --upload-app -f build/ios/ipa/Destiny.ipa -t ios -u <username> -p <app passowd>
```

## MacOS

In order to build signed macos releases, a valid code signing certificate needs to be added to the key chain.
In XCode, select the corresponding provisioning profile that uses your code signing certificate.

```bash
flutter build macos lib/main_la.dart -v --dart-define version=$(git describe) --build-name $(git describe) 
NOTARIZATION_USERNAME="<your-apple-id>" NOTARIZATION_PASSWORD='<app-specific-password>' ./scripts/notarize.py app
create-dmg --app-drop-link 0 0 build/macos/Build/Products/Release/Destiny.dmg build/macos/Build/Products/Release/Destiny.app
NOTARIZATION_USERNAME="<your-apple-id>" NOTARIZATION_PASSWORD='<app-specific-password>' ./scripts/notarize.py dmg
```

## Source tarball

The script at `scripts/create-source-tarball.sh` should create a tarball.

## Creating a detached signature

Examples:
```bash
gpg2 -b -u FEFCF3E1A6D29483A90C4FAD14431C152E30A826 destiny-v0.24.1-src.tar.gz
```

```bash
gpg2 -b -u 7E1D9E7CEB26F3EA0E746B6031634243DCDBDED7 destiny-v0.24.1-src.tar.gz
```

## Verifying a download

Import all public keys under `doc/signing_keys`

To verify a download, download the `.sig` file corresponding to your download
and run `gpg2 --verify <path of the sig file>`

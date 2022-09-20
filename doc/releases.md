# Signing releases and verification

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

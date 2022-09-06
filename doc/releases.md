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

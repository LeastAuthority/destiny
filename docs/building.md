# Building details

## iOS building documentation

### *Prerequisit*: 
* macOS and Xcode is necessary to build iOS or macOS app (Alternatively, may be Xcode cloud could be used).
* flutter (latest)
* cmake (latest)
* cocoapods (latest)
* workstation (preferrable M1, as it compiles for arm64)

*Note:* iphonesimulator runs on arch: x86_64, iphone on arm64

Check enviroment variables:
* FLUTTER_ROOT
* GOROOT
* Homebrew bin is in PATH


Apple Developer account is necessary only if you want to sign and release or you want to install on your own iPhone devices

### *Basic commands:*

Build cleanup: `flutter clean && cd dart_wormhole_william && flutter clean && cd ..`

Additional cleanup: `rm -rf ios/Pods && rm ios/Podfile.loc`

Build ios app debug version with stage servers: `flutter build ios -t lib/main_stage_la.dart --debug`

Build ios app release version with production servers: `flutter build ios -t lib/main_la.dart --debug`

Build and run on simulator or connected iPhone: `flutter run`

Check available devices: `flutter devices`

### *Other notes*

Alternative you can build and run in Xcode, however it not works on every workstation straight away (it execute a little bit differently then flutter commands). Build in Xcode, can give more detail description if something is failing.

If Xcode build fails, first try to build with flutter command: `flutter build ios` and then rebuild in Xcode

For signing: 
* Add apple developer account in Xcode.
* Set in Runner->Signing & Capabilities, your team, which you are signing and Enable automatically manage signing

iOS load static libraries, you can find and check if libraries are build and in which arch: `find . -name "*.a" -exec objdump -x {} \;`

Helps to find for some parameters in logs: `rg STRIP_STYLE` or in absolutely all files: `rg -uuu STRIP_STYLE`

Main files to check compilation scripts:
* dart_wormhole_william/ios/CMakeLists.txt
* dart_wormhole_william/ios/dart_wormhole_william.podspec
* dart_wormhole_william/lib/src/CMakeLists.txt
* dart_wormhole_william/CMakeLists.txt

To check if libraries compiled, included in build and linked properly, run app in iPhone or iPhonesimulator, go to Sender try to load File or Media, code should be generated. Alternatively, you can go to receiver and enter failed code: 1-2-3 and get message: "Something went wrong".
Note: If you get error: `PlatformException(file_picker_error, Temporary file could not be created`, simulator might have a bug when selecting Media file. Try select any other media file. Also in Destiny application settings, set Document storage: Phone.

### *Troubleshooting*

Sharing some issues, faced during enabling iOS build:

* Failed to lookup symbol 'init_dart_api_dl' iphone simulator - helped setting in Runner->Build Settings->Build Active Architecture Only = Yes
* Architecture miscompilation and loading arm64 vs amd64 (x86_64). Iphone runs on Arm64, MacBook M1-chip runs on Arm64, MacBook intel runs on amd64, iPhoneSimulator runs on x86_64. We have flutter app, dart_wormhole_william and wormhole_william. All this must match to what you build




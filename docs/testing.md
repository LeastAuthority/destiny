# Testing documentation

## Manual testing scenarios:

### Basic scenarios:
 - Send file
 - Receive file
 - Enter invalid code (existing number, wrong wordcode)
 - Enter incorrect code
 - Reject offer on Receiver side
 - Cancel transfer on Receiver side
 - Cancel transfer on Sender side
 - Check settings:
  - Links (Feedback, FAQ, Privacy, Terms) visible, clickable and open docs
  - version
  - environment settings (maiblox, transit, appID) visible and editable
 - Change mailbox addresses and check if code generation works

### Interoperability checks:
 - Mobile iOS -> Desktop macOS
 - Desktop macOS -> Mobile iOS
 - Mobile iOS -> Winden.app
 - Winden App -> Mobile iOS
 - Mobile iOS -> Magic-Wormhole CLI
 - Magic-Wormhole CLI -> Mobile iOS

### Network checks:
 - Check direct TCP send
 - Check via relay WebSockent send

### Android specific checks
 - Check if app runs on minimum and maximum SDK
 - Upload to Google Play store and release under Internal testing and install on real device

### iOS specific checks
 - Check if build and run for iosphonesimulator (x86_64)
 - Check if build and run for iphone (arm64)
 - Upload to App Developer account in TestFlight. Install on real device

### macOS specific checks
 - 

### linux specific checks
 - Run AppImage and peform file sending

### Windoes specific checks
 - Run app from zip on Windows 10 and 11

### Post-release checks
- Check mailbox and transit-relay urls are production ones
- Install and run on each real device for each platform (try send file, code generates)
- Try install from signed msix file
- Try install from signed dmg file and no security warnings displayed

## Testing template:

Testing template can be found in `docs/__Charter-Template__ Destiny-QA .ods`
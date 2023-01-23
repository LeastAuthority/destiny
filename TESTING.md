# Testing documentation

## Manual testing scenarios

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


### Interoperability check:
 - Mobile iOS -> Desktop macOS
 - Desktop macOS -> Mobile iOS
 - Mobile iOS -> Winden.app
 - Winden App -> Mobile iOS
 - Mobile iOS -> Magic-Wormhole CLI
 - Magic-Wormhole CLI -> Mobile iOS

### Network check:
 - Check direct TCP send
 - Check via relay WebSockent send


### Android specific tests

### iOS specific tests

### macOS specific tests

### linux specific tests

### Windoes specific tests
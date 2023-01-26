# Installation Instructions

## Android 
### Via Google Play Store (*recommended*)
1. Open Play Store app
2. Search for an app with the name *Destiny Secure File Transfer*
   or open a direct link to the [Play store](https://play.google.com/store/apps/details?id=com.leastauthority.destiny).
3. Press Install

### Via F-Droid Store (*privacy friendly*)
1. Open F-Droid Store app or if you don't have, go to (F-Droid.org)[https://f-droid.org/] to install it
2. Search for an app with the name *Destiny*
   or open a direct link to the [F-Droid store](https://f-droid.org/en/packages/com.leastauthority.destiny/).
3. Press Download APK

### Manual APK file install 
1. Download [**destiny_android.apk**](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_android.apk)
2. Open `destiny_android.apk` file
3. There might be a popup asking if you really want to install, press Install

**Note**: *installing directly is not recommended, also there won't be automatic updates*

## Windows
### MSIX (*recommended*)

1. Download [**destiny_windows.msix**](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_windows.msix)
2. Run the MSIX file
3. Press Install on Installer window
4. Search and run `destiny.exe`

### ZIP

1. Download [**destiny_windows.zip**](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_windows.zip)
2. Extract the zip
3. Run `destiny.exe`
**Note**: might require additional libraries


## macOS (M1 or Intel chip based)

1. Download [**destiny_macos.dmg**](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_macos.dmg)
2. Open downloaded DMG file
3. Drag and drop Destiny icon in Applications folder
4. Search and run `Destiny`

## Linux (x64)
### AppImage (*recommended*)

1. Download [**destiny_linux_amd64.AppImage**](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_linux_amd64.AppImage)
2. Run chmod u+x `destiny_linux_amd64.AppImage && ./destiny_linux_amd64.AppImage`
**Note**: If your system does not have FUSE you can [extract the appimage](https://github.com/AppImage/AppImageKit/wiki/FUSE#type-2-appimage):
     ```
     ./destiny_linux_amd64.AppImage --appimage-extract
     ./squashfs-root/AppRun
    ```

### Tarball

1. Download [**destiny_linux_amd64.tar.gz**](https://github.com/LeastAuthority/destiny/releases/latest/download/destiny_linux_amd64.tar.gz)
2. Extract `tar xzvf destiny_linux_amd64.tar.gz`
4. Go inside directory `destiny_linux`
5. Run `./destiny`


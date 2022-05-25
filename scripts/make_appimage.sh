#!/usr/bin/env bash

APPNAME=Destiny
parent=$(mktemp -d XXXX-appimage)
APPDIR=$(pwd)/$parent/$APPNAME.AppDir

mkdir -p $APPDIR/usr/share/icons $APPDIR

cp -v build/linux/x64/release/bundle/destiny $APPDIR/AppRun
cp -v build/linux/x64/release/bundle/data/flutter_assets/assets/images/logo.png $APPDIR/destiny.png
cp -v build/linux/x64/release/bundle/data/flutter_assets/assets/images/logo.png $APPDIR/usr/share/icons/destiny.png
cp -v $APPDIR/destiny.png $APPDIR/.DirIcon

cat >$APPDIR/destiny.desktop <<EOL
[Desktop Entry]
Type=Application
Icon=destiny
Exec=AppRun
Name=Destiny
Categories=Network;
GenericName=Secure file transfer
EOL
cp -rv build/linux/x64/release/bundle/lib/ $APPDIR
cp -rv build/linux/x64/release/bundle/data/ $APPDIR

cd $parent
wget "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
chmod a+x appimagetool-x86_64.AppImage
./appimagetool-x86_64.AppImage $APPDIR
cp -rv Destiny-x86_64.AppImage $APPDIR/../..

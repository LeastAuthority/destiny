import 'dart:io';

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/shared/util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsShared<T extends SettingsState> extends State<T> {
  SharedPreferences? prefs;

  String? get path {
    final path = prefs?.get(PATH);

    if (path != null && path is String) {
      return path;
    }

    return defaultPathForPlatform;
  }

  late String? defaultPathForPlatform = '';

  SettingsShared() {
    SharedPreferences.getInstance().then((prefs) => setState(() {
          this.prefs = prefs;
        }));

    if (Platform.isAndroid) {
      defaultPathForPlatform = ANDROID_DOWNLOADS_FOLDER_PATH;
    } else {
      getDownloadsDirectory().then((downloadsDir) {
        defaultPathForPlatform = downloadsDir?.path;
      });
    }
  }

  void handleSelectFile() async {
    await canWriteToFile().then((permissionStatus) async {
      if (permissionStatus == PermissionStatus.granted) {
        String? result = await FilePicker.platform.getDirectoryPath();
        if (result == null) {
          return;
        }
        setState(() {
          prefs?.setString(PATH, result);
        });
      }
    });
  }

  Widget build(BuildContext context);
}

abstract class SettingsState extends StatefulWidget {
  SettingsState({Key? key}) : super(key: key);
}

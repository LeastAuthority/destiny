import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

const int KB = 1000;
const int MB = 1000 * KB;
const int GB = 1000 * MB;
const int TB = 1000 * GB;
const int PB = 1000 * TB;
const int EB = 1000 * PB;
const int MINUTE_IN_SECONDS = 60;

extension BytesToReadableSize on int {
  String get readableSize {
    if (this < KB) {
      return "${this} B";
    } else if (this < MB) {
      return "${(this / KB).toStringAsFixed(1)} KB";
    } else if (this < GB) {
      return "${(this / MB).toStringAsFixed(1)} MB";
    } else if (this < TB) {
      return "${(this / GB).toStringAsFixed(1)} GB";
    } else if (this < PB) {
      return "${(this / TB).toStringAsFixed(1)} TB";
    } else if (this < EB) {
      return "${(this / PB).toStringAsFixed(1)} PB";
    } else {
      return "YUGE file transfer ";
    }
  }
}

String nonExistingPathFor(String path) {
  if (File(path).existsSync()) {
    int i = 1;
    String baseName = path.split(Platform.pathSeparator).last;
    String directory = File(path).parent.path;
    String? extension;
    if (baseName.contains(".")) {
      final parts = baseName.split(".");
      baseName = parts.take(parts.length - 1).join("");
      extension = parts.last;
    }
    String nextPath() => extension != null
        ? "$directory/$baseName($i).$extension"
        : "$directory/$baseName($i)";
    while (File(nextPath()).existsSync()) {
      i++;
    }

    return "${nextPath()}";
  } else {
    return path;
  }
}

Future<bool> canWriteToDirectory(String directory) async {
  try {
    String path = nonExistingPathFor('$directory/test');
    if (Platform.isAndroid) {
      bool isGranted =
          await Permission.storage.request() == PermissionStatus.granted;
      if (isGranted == false) return false;
    }
    File(path).writeAsBytesSync([]);
    File(path).deleteSync();
    return true;
  } catch (e) {
    return false;
  }
}

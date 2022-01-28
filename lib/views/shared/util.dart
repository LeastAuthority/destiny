import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

const int KB = 1000;
const int MB = 1000 * KB;
const int GB = 1000 * MB;
const int TB = 1000 * GB;
const int PB = 1000 * TB;
const int EB = 1000 * PB;

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

Future<PermissionStatus> canWriteToFile() async {
  if (Platform.isAndroid) {
    return await Permission.storage.request();
  } else if (Platform.isLinux) {
    return PermissionStatus.granted;
  } else {
    print("Implement write checks for ${Platform()}");
    return PermissionStatus.permanentlyDenied;
  }
}

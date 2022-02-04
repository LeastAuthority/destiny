import 'dart:io';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
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

extension TimeRemaining on int {
  String get timeRemainingInProperUnit {
    double time = this / MINUTE_IN_SECONDS;
    if (time == 1) {
      return "1 $MINUTE";
    } else if (time < 1) {
      return "${this} $SECONDS";
    } else {
      return "${(this / MINUTE_IN_SECONDS).toStringAsFixed(1)} $MINUTES";
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

String getRemainingTime(
    DateTime currentTimeGetter,
    DateTime startingTime,
    int totalProcessed,
    int previousProcessed,
    int totalSize,
    int processedPerSecond,
    Function updateState) {
  Duration duration = currentTimeGetter.difference(startingTime);
  if ((totalProcessed - previousProcessed) > 0 && duration.inSeconds >= 1) {
    updateState();
  }
  int remainingTimeInSeconds =
      ((totalSize - totalProcessed) ~/ processedPerSecond);
  return remainingTimeInSeconds.timeRemainingInProperUnit;
}

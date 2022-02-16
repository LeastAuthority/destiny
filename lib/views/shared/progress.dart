import 'dart:ffi';

import 'package:dart_wormhole_william/client/c_structs.dart';

// How many milliseconds to wait before updating the remaining time
const ETA_REFRESH_INTERVAL_MILLIS = 500;

class ProgressShared {
  int? totalTransferred;
  int? totalSize;
  DateTime? lastProgress;
  int? lastTransferred;
  Duration? remainingTime;

  Function setState;
  Function otherStateChange;

  ProgressShared(this.setState, this.otherStateChange);

  double? get percentage {
    if (totalSize != null && totalTransferred != null) {
      return totalTransferred! / totalSize!;
    } else {
      return null;
    }
  }

  String? get remainingTimeString {
    if (remainingTime != null) {
      if (remainingTime!.inDays > 0) {
        return "${remainingTime!.inDays} Days";
      } else if (remainingTime!.inHours > 0) {
        return "${remainingTime!.inHours} Hours";
      } else if (remainingTime!.inMinutes > 0) {
        return "${remainingTime!.inMinutes} Minutes";
      } else {
        return "${remainingTime!.inSeconds} Seconds";
      }
    } else {
      return null;
    }
  }

  void progressHandler(dynamic progress) {
    if (progress is int) {
      var progressC = Pointer<Progress>.fromAddress(progress);
      setState(() {
        otherStateChange();
        totalTransferred = progressC.ref.transferredBytes;
        totalSize = progressC.ref.totalBytes;
        if (lastProgress != null && lastTransferred != null) {
          final millisSinceLastUpdate =
              DateTime.now().difference(lastProgress!).inMilliseconds;

          if (millisSinceLastUpdate >= ETA_REFRESH_INTERVAL_MILLIS) {
            if (totalTransferred != null &&
                lastTransferred != null &&
                totalSize != null) {
              final speedInBytesPerMillisecond =
                  (totalTransferred! - lastTransferred!) /
                      millisSinceLastUpdate;
              remainingTime = Duration(
                  milliseconds: ((totalSize! - totalTransferred!) ~/
                      speedInBytesPerMillisecond));
            }

            lastTransferred = progressC.ref.transferredBytes;
            lastProgress = DateTime.now();
          }
        } else {
          lastTransferred = progressC.ref.transferredBytes;
          lastProgress = DateTime.now();
        }
      });
    } else {
      print(
          "Wrong type for progress. Expected int got ${progress.runtimeType}");
    }
  }
}

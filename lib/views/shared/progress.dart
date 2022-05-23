import 'dart:ffi';

import 'package:dart_wormhole_william/client/c_structs.dart';
import 'package:flutter/widgets.dart';

// How many milliseconds to wait before updating the remaining time
const ETA_REFRESH_INTERVAL_MILLIS = 500;

class ProgressSharedState extends ChangeNotifier {
  late int totalTransferred;
  late int totalSize;

  DateTime? lastProgress;
  int? lastTransferred;

  Duration? remainingTime;

  Function setState;
  Function otherStateChange;

  ProgressSharedState(this.setState, this.otherStateChange);

  double get percentage {
    try {
      return totalTransferred / totalSize;
    } catch (error) {
      return 0;
    }
  }

  String? get remainingTimeString {
    if (remainingTime != null) {
      late final String unit;
      late final int amount;

      if (remainingTime!.inDays > 0) {
        unit = "Day";
        amount = remainingTime!.inDays;
      } else if (remainingTime!.inHours > 0) {
        unit = "Hour";
        amount = remainingTime!.inHours;
      } else if (remainingTime!.inMinutes > 0) {
        unit = "Minute";
        amount = remainingTime!.inMinutes;
      } else {
        unit = "Second";
        amount = remainingTime!.inSeconds;
      }

      return amount == 0
          ? null
          : amount == 1
              ? "$amount $unit"
              : "$amount ${unit}s";
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
            if (lastTransferred != null) {
              final speedInBytesPerMillisecond =
                  (totalTransferred - lastTransferred!) / millisSinceLastUpdate;
              remainingTime = Duration(
                  milliseconds: ((totalSize - totalTransferred) ~/
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

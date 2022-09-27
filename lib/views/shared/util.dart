import 'dart:io';
import 'dart:typed_data';
import 'package:cross_file/cross_file.dart';
import 'package:dart_wormhole_william/client/file.dart' as f;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        ? "$directory" + Platform.pathSeparator + "$baseName($i).$extension"
        : "$directory" + Platform.pathSeparator + "$baseName($i)";
    while (File(nextPath()).existsSync()) {
      i++;
    }

    return "${nextPath()}";
  } else {
    return path;
  }
}

List<Container> convertErrorMessageIntoParagraphs(String? errorMessage,
    TextStyle? textStyle, TextAlign textAlign, BuildContext context) {
  return errorMessage
          ?.split("\n")
          .map((txt) => Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.zero,
                child: Text(
                  txt,
                  style: textStyle,
                  textAlign: textAlign,
                ),
              ))
          .toList() ??
      [];
}

Future<bool> isAndroidStoragePermissionsGranted() async {
  bool isGranted;
  isGranted = await Permission.storage.request() == PermissionStatus.granted;
  return isGranted;
}

Future<bool> canWriteToDirectory(String directory) async {
  try {
    String path = nonExistingPathFor('$directory/test');
    if (Platform.isAndroid &&
        await isAndroidStoragePermissionsGranted() == false) return false;
    File(path).writeAsBytesSync([]);
    File(path).deleteSync();
    return true;
  } catch (e) {
    return false;
  }
}

extension WriteOnlyFileFile on File {
  f.File writeOnlyFile() {
    final openFile = File(this.path).openWrite(); // this.openWrite();
    return f.File(write: (Uint8List buffer) async {
      openFile.add(buffer);
      await openFile.flush();
    }, close: () async {
      await openFile.close();
      await openFile.done;
    });
  }

  f.File readOnlyFile() {
    final openFile = File(this.path).open();
    return f.File(read: (Uint8List buffer) async {
      return await (await openFile).readInto(buffer);
    }, close: () async {
      await (await openFile).close();
    }, setPosition: (int position) async {
      await (await openFile).setPosition(position);
    }, getPosition: () async {
      return await (await openFile).position();
    }, metadata: () async {
      final file = await openFile;
      return f.Metadata(
          fileName: file.path.split(Platform.pathSeparator).last,
          fileSize: await file.length());
    });
  }
}

extension ReadOnlyXFileFile on XFile {
  f.File readOnlyFile() {
    final openFile = File(this.path).openSync();
    return f.File(
        read: (Uint8List buffer) async {
          return await openFile.readInto(buffer);
        },
        close: () async {
          return await openFile.close();
        },
        metadata: () async {
          return f.Metadata(fileName: this.name, fileSize: await this.length());
        },
        getPosition: openFile.position,
        setPosition: openFile.setPosition);
  }
}

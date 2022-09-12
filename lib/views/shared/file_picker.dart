import 'dart:io' as io;

import 'package:dart_wormhole_william/client/file.dart';
import 'package:file_picker/file_picker.dart' as file_picker_plugin;
import 'package:flutter/services.dart';

abstract class FilePicker {
  Future<File> showSelectFile();
}

extension AsFile on String? {
  static const fileIOChannel = MethodChannel("destiny.android/file_io");

  Future<File> androidUriToReadOnlyFile() async {
    var targetOffset = 0;
    var currentOffset = 0;

    Future<int> readInto(Uint8List buffer) async {
      final readResult = await fileIOChannel
          .invokeMethod<List>("read_bytes", <String, dynamic>{
        "uri": this,
        "max": buffer.length,
      });
      final bytesRead = readResult?.first as int;
      final bytes = readResult?.skip(1).first as Uint8List;
      for (int i = 0; i < bytesRead; i++) {
        buffer[i] = bytes[i];
      }
      currentOffset += bytesRead;
      return bytesRead;
    }

    Future<int> seekAndReadInto(Uint8List buffer) async {
      if (targetOffset > currentOffset) {
        // Discard bytes that should be skipped
        await readInto(Uint8List(targetOffset - currentOffset));
      }

      return readInto(buffer);
    }

    final metadata = await fileIOChannel
        .invokeMethod<List>("get_metadata", <String, dynamic>{"uri": this});

    return File(
        metadata: () async {
          return Metadata(
              fileName: metadata![0] as String,
              parentPath: metadata[1] as String,
              fileSize: metadata[2] as int);
        },
        read: seekAndReadInto,
        close: () async {
          await fileIOChannel.invokeMethod<void>(
              "close_reader", <String, dynamic>{"uri": this});
        },
        setPosition: (position) async {
          if (currentOffset > position) {
            throw Exception("Seeking backwards on Android is not supported");
          }
          targetOffset = position;
        },
        getPosition: () async {
          return targetOffset;
        });
  }

  Future<File> androidUriToWriteOnlyFile() async {
    return File(write: (Uint8List bytes) async {
      await fileIOChannel.invokeMethod<void>(
          "write_bytes", <String, dynamic>{"uri": this, "bytes": bytes});
    }, close: () async {
      await fileIOChannel
          .invokeMethod<void>("close_writer", <String, dynamic>{"uri": this});
    }, metadata: () async {
      final metadata = await fileIOChannel
          .invokeMethod<List>("get_metadata", <String, dynamic>{"uri": this});

      return Metadata(
          fileName: metadata![0] as String,
          parentPath: metadata[1] as String,
          fileSize: metadata[2] as int);
    });
  }
}

class _AndroidFilePicker extends FilePicker {
  static const fileSelectorChannel =
      MethodChannel("destiny.android/file_selector");

  @override
  Future<File> showSelectFile() async {
    return fileSelectorChannel
        .invokeMethod<String>("select_file")
        .then((uriString) async {
      return uriString.androidUriToReadOnlyFile();
    });
  }
}

class _DesktopFilePicker extends FilePicker {
  @override
  Future<File> showSelectFile() {
    return file_picker_plugin.FilePicker.platform
        .pickFiles(allowMultiple: false)
        .then((result) async {
      assert(result?.files.length == 1);
      final openFile = await io.File((result?.files.first.path)!).open();
      return File(
          metadata: () async {
            return Metadata(
                fileName: result?.files.first.name,
                fileSize: result?.files.first.size);
          },
          read: openFile.readInto,
          getPosition: openFile.position,
          setPosition: openFile.setPosition,
          close: openFile.close);
    });
  }
}

FilePicker getFilePicker() {
  return io.Platform.isAndroid ? _AndroidFilePicker() : _DesktopFilePicker();
}

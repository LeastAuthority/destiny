import 'dart:io' as io;
import 'dart:typed_data';

import 'package:dart_wormhole_william/client/file.dart';
import 'package:file_picker/file_picker.dart' as file_picker_plugin;
import 'package:flutter/services.dart';

abstract class FilePicker {
  Future<File> showSelectFile();
}

class _AndroidFilePicker extends FilePicker {
  static const fileSelectorChannel =
      MethodChannel("destiny.android/file_selector");

  @override
  Future<File> showSelectFile() async {
    return fileSelectorChannel
        .invokeMethod<String>("select_file")
        .then((uriString) async {
      final readInto = (Uint8List buffer) async {
        final readResult = await fileSelectorChannel
            .invokeMethod<List>("read_bytes", <String, dynamic>{
          "uri": uriString,
          "max": buffer.length,
        });
        final bytesRead = readResult?.first as int;
        final bytes = readResult?.skip(1).first as Uint8List;
        for (int i = 0; i < bytesRead; i++) {
          buffer[i] = bytes[i];
        }
        return bytesRead;
      };

      final metadata = await fileSelectorChannel.invokeMethod<List>(
          "get_metadata", <String, dynamic>{"uri": uriString});

      var fakePosition = 0;

      return File(
          metadata: () async {
            return Metadata(
                fileName: metadata!.first as String,
                fileSize: metadata[1] as int);
          },
          read: readInto,
          close: () async {
            await fileSelectorChannel.invokeMethod<void>(
                "close", <String, dynamic>{"uri": uriString});
          },

          // TODO This is an ugly workaround
          // Seek is not supported backwards on Android
          // Wormhole-william uses seek to determine the file size
          // By seeking to the end of the file and back
          setPosition: (position) async {
            fakePosition = position;
          },
          getPosition: () async {
            return fakePosition;
          });
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

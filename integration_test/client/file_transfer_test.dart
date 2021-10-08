import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;
import 'package:flutter_test/flutter_test.dart';

import 'package:dart_wormhole_william/client/client.dart';
import './cli_util.dart';

void main() {
  setUpAll(() async {
    await buildGoCli();
  });

  group('Send / receive file', () {
    // TODO: loop over all sizes
    final testFilename = '100KB';
    final smallerFilePath = path.join(testFileSrcDir, testFilename);
    final smallerFile = File(smallerFilePath);

    tearDown(() async {
      try {
        final file = File(path.join(testFileDestDir, testFilename));
        await file.delete();
      } catch (e) {}
    });

    test('dart API -> go CLI', () async {
      final sender = Client();

      final result = await sender.sendFile(smallerFile);
      final code = result.code;
      expect(code, isNotEmpty);
      expect(result.done, completes);

      final actualFile = await recvFileGo(code, testFilename);

      final actual = actualFile.readAsBytesSync();
      final testData = smallerFile.readAsBytesSync();
      expect(actual, orderedEquals(testData));
    });

    test('go CLI -> dart API', () async {
      final receiver = Client();

      final code = await sendFileGo(testFilename);
      expect(code, isNotEmpty);

      final actualData = await receiver.recvFile(code);
      final testData = smallerFile.readAsBytesSync();
      expect(actualData, orderedEquals(testData));
    });

    test('dart API -> dart API', () async {
      final sender = Client();
      final receiver = Client();

      final result = await sender.sendFile(smallerFile);
      final code = result.code;
      expect(code, isNotEmpty);
      expect(result.done, completes);

      final actualData = await receiver.recvFile(code);
      final testData = smallerFile.readAsBytesSync();
      expect(actualData, orderedEquals(testData));
    });
  });
}

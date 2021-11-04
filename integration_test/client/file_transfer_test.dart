import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;

import 'package:dart_wormhole_william/client/client.dart';

import './cli_util.dart';

void main() {
  final tempDir = Directory.systemTemp.createTempSync("wormhole_test_files");
  final random = Random(9001);
  const fileSizesInKb = [1, 10, 100, 1000, 10000, 300000];
  const maxKbPerWrite = 1000;

  setUpAll(() async {
    await buildGoCli(path.join(tempDir.path, "go_cli"));
  });

  String createFile(int kbs) {
    var tempFile = File(path.join(tempDir.path, "${kbs}KB"));

    tempFile.createSync();
    var sink = tempFile.openSync(mode: FileMode.write);
    for (int i = 0; i < kbs;) {
      var kbsToWrite = i + maxKbPerWrite < kbs ? maxKbPerWrite : kbs - i;
      sink.writeFromSync(
          List.generate(1000 * kbsToWrite, (index) => random.nextInt(256)));
      i += kbsToWrite;
    }

    return tempFile.path;
  }

  for (int size in fileSizesInKb) {
    group('Send / receive file ${size}KB', () {
      final testFilePath = createFile(size);

      test('dart API -> go CLI', () async {
        final sender = Client();

        final result = await sender.sendFile(File(testFilePath));
        final code = result.code;
        expect(code, isNotEmpty);
        expect(result.done, completes);

        final actualFile = await recvFileGo(code, path.basename(testFilePath));

        final actual = actualFile.readAsBytesSync();
        final testData = File(testFilePath).readAsBytesSync();
        expect(sha256.convert(actual), equals(sha256.convert(testData)));
      });

      test('go CLI -> dart API', () async {
        final receiver = Client();

        final code = await sendFileGo(testFilePath);
        expect(code, isNotEmpty);

        final actualData = await receiver.recvFile(code);
        final testData = File(testFilePath).readAsBytesSync();

        expect(sha256.convert(actualData), equals(sha256.convert(testData)));
      });

      test('dart API -> dart API', () async {
        final sender = Client();
        final receiver = Client();

        final result = await sender.sendFile(File(testFilePath));
        final code = result.code;
        expect(code, isNotEmpty);
        expect(result.done, completes);

        final actualData = await receiver.recvFile(code);
        final testData = File(testFilePath).readAsBytesSync();
        expect(sha256.convert(actualData), equals(sha256.convert(testData)));
      });
    });
  }

  tearDownAll(() {
    try {
      tempDir.deleteSync(recursive: true);
    } catch (e) {}
  });
}

import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:flutter_test/flutter_test.dart';

import 'package:dart_wormhole_william/client/client.dart';
import 'package:dart_wormhole_william/client/config.dart';
import './cli_util.dart';

void main() {
  final tempDir = Directory.systemTemp.createTempSync("wormhole_test_files");
  final testConfig = Config(
    rendezvousUrl: 'ws://localhost:4000/v1',
    transitRelayUrl: 'tcp:localhost:4001',
  );

  setUpAll(() async {
    await buildGoCli(path.join(tempDir.path, "go_cli"));
  });

  group('Send / receive text', () {
    const expectedText = 'testing 123';

    test('dart API -> dart API', () async {
      final sender = Client(config: testConfig);
      final receiver = Client(config: testConfig);

      final result = await sender.sendText(expectedText);
      final code = result.code;
      expect(code, isNotEmpty);
      expect(result.done, completes);

      final actual = await receiver.recvText(code);
      expect(actual, expectedText);
    });

    test('dart API -> go CLI', () async {
      final sender = Client(config: testConfig);

      final result = await sender.sendText(expectedText);
      final code = result.code;
      expect(code, isNotEmpty);

      final actual = recvTextGo(code);

      expect(actual, expectedText);
      expect(result.done, completes);
    });

    // test('go CLI -> dart API', () async {
    //   final receiver = Client();
    //
    //   final code = sendTextGo(expectedText);
    //   // TODO: something more robust!
    //   sleep(Duration(seconds: 5));
    //   final actual = await receiver.recvText(code);
    //
    //   // expect(code, isNotEmpty);
    //   expect(actual, expectedText);
    // });
  });
}

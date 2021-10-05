import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';

import 'package:dart_wormhole_william/client/client.dart';
import './cli_util.dart';

void main() {

  group('Send / receive file', () {
    const testName = 'testFile';
    const testSize = 10;
    const testDataText = "this is a test; testing 123";
    final testData = Uint8List.fromList(testDataText.codeUnits.toList());

    test('dart API -> dart API', () async {
      final sender = Client();
      final receiver = Client();

      final result = await sender.sendFile(testName, testSize, testData);
      final code = result.code;
      expect(code, isNotEmpty);
      expect(result.done, completes);

      final actual = await receiver.recvFile(code);
      expect(String.fromCharCodes(actual), testDataText);
    });
  });
}

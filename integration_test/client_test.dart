import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';

import 'package:dart_wormhole_william/client/client.dart';
import 'util.dart';

void main() {
  group('Send / receive text', () {
    const expectedText = 'testing 123';

    test('dart API -> dart API', () async {
      final sender = Client();
      final receiver = Client();

      final result = await sender.sendText(expectedText);
      final code = result.code;
      expect(code, isNotEmpty);
      expect(result.done, completes);

      final actual = await receiver.recvText(code);
      expect(actual, expectedText);
    });

    test('dart API -> go CLI', () async {
      final sender = Client();

      final result = await sender.sendText(expectedText);
      final code = result.code;
      expect(code, isNotEmpty);

      final actual = recvTextGo(code);

      expect(actual, expectedText);
      expect(result.done, completes);
    });

    test('go CLI -> dart API', () async {
      final receiver = Client();

      final code = sendTextGo(expectedText);
      final actual = await receiver.recvText(code);

      // expect(code, isNotEmpty);
      expect(actual, expectedText);
    });
  });

//   group('Send / receive file', () {
//     test('dart API -> dart API', () async {
//       final sender = Client();
//       final receiver = Client();
//
//       final result = await sender.sendFile(testName, testSize, testData);
//       final code = result.code;
//       expect(code, isNotEmpty);
//       expect(result.done, completes);
//
//       final actual = await receiver.recvFile(code);
//       expect(actual, expectedText);
//     });
//   });
}

import 'package:flutter_test/flutter_test.dart';

import 'package:dart_wormhole_william/client/client.dart';
import 'util.dart';

void main() {
    group('Send / receive text', () {
      // late FlutterDriver driver;

      const expectedText = 'testing 123';

      // setUpAll(() async {
      //   driver = await FlutterDriver.connect();
      // });
      //
      // tearDownAll(() {
      //   driver.close();
      // });

      test('dart API -> dart API', () async {
        final sender = Client();
        final receiver = Client();

        final result = await sender.sendText(expectedText);
        final code = result.code;
        expect(code, isNotEmpty);
        expect(result.done, completes);

        final actual = await receiver.recvText(code);
        print(actual);
        expect(actual, expectedText);
      });

      // test('dart API -> go CLI', () async {
      //   final sender = Client();
      //
      //   final result = await sender.sendText(expectedText);
      //   final code = result.code;
      //   expect(code, isNotEmpty);
      //
      //   final actual = recvTextGo(code);
      //
      //   expect(actual, expectedText);
      //   expect(result.done, completes);
      // });
      //
      // test('go CLI -> dart API', () async {
      //   final receiver = Client();
      //
      //   final code = sendTextGo(expectedText);
      //   final actual = await receiver.recvText(code);
      //
      //   // expect(code, isNotEmpty);
      //   expect(actual, expectedText);
      // });
    });

    // group('Send / receive file', () {
    //   test('dart API -> dart API', () {
    //   });
    // });
  // });

//   group('ClientNative', () {
// //    String _dylibDir = path.join(
// //        Directory.current.path, '..', 'wormhole-william', 'build');
//     // TODO: figure this out!
//
//     test('#newClient', () {
//       NativeClient _native = NativeClient();
//       // TODO test anything here
//     });
//
//     late NativeClient _native;
//     int goClient = -1;
//     Pointer<Utf8> codeC = ''.toNativeUtf8();
//
//     String testMsg = "testing 123";
//     Pointer<Utf8> testMsgC = testMsg.toNativeUtf8();
//     Pointer<Pointer<Utf8>> codeOutC = calloc();
//
//     test('#clientSendText', () {
//       // TODO: figure out.
//       //  "Unsupported operation: Operation 'toDartString' not allowed on a 'nullptr'" unless initially set.
//       codeOutC.value = ''.toNativeUtf8();
//
//       _native = NativeClient();
//
//       // TODO test
//
//       /*expect(goClient, isNonNegative);*/
//       /*expect(goClient, isNonZero);*/
//
//       // TODO FIXME
//       // int statusCode = _native.clientSendText(goClient, testMsgC, codeOutC);
//       // expect(statusCode, isZero);
//       /*expect(codeOutC.value, isNotNull);*/
//       /*expect(codeOutC.value.toDartString(), isNotEmpty);*/
//       codeC = codeOutC.value;
//     });
//
//     test('#clientRecvText', () {
//       Pointer<Pointer<Utf8>> msgOutC = calloc();
//
//       // int statusCode = _native.clientRecvText(code, msgOut)
//       /*expect(statusCode, isZero);*/
//       /*expect(msgOutC.value, isNotNull);*/
//       /*expect(msgOutC.value.toDartString(), testMsg);*/
//     });
//   });
//
//   group('Client', () {
//     Client client = Client();
//     String testMsg = 'testing 456';
//     late String code;
//
//     test('#sendText', () {
//       // TODO confirm this
//       client
//           .sendText(testMsg)
//           .then((code) => expect(code, isNotEmpty))
//           .onError((error, stackTrace) => fail(error.toString()));
//       // expect(code, isNotEmpty);
//     });
//
//     test('#recvText', () {
//       // TODO fix this
//       //String msg = client.recvText(code);
//       //expect(code, isNotEmpty);
//       //expect(msg, testMsg);
//     });
//   });
}

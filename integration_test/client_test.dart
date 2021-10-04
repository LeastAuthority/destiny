import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:dart_wormhole_william/client/client.dart';

class ClientTestWidget extends StatelessWidget {
  static const expectedText = 'testing 123';

  String actualText = '';
  String code = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(builder: (BuildContext context, Widget? widget) {
      return Column(children: [
        Text("Tests:"),
        TextButton(
          child: Text("send/recv text dart-api"),
          onPressed: testSendRecvTextDartDart,
        ),
        TextButton(
          child: Text("send text dart-api recv text go-cli"),
          onPressed: testSendRecvTextDartGo,
        ),
        TextButton(
          child: Text("send text go-cli recv text dart-api"),
          onPressed: testSendRecvTextGoDart,
        ),
        // TextButton(
        //   child: Text("run test"),
        //   onPressed: testRun,
        // ),
      ]);
    });
  }

  void testRecvTextGo(String code) {
    final res = Process.runSync('go', [
      'run',
      '.',
      'receive',
      code,
    ],
      // TODO: replace with OS-agnostic path
      workingDirectory: './dart_wormhole_william/wormhole-william',
    );
    print(res.stdout);
  }

  void testSendRecvTextDartGo() {
    final sender = Client();

    sender.sendText(expectedText).then((result) {
      code = result.code;
      print('sent $expectedText');
      result.done.then((_) {
        print('Dart | client_test:62 send done!');
      });

      // use shell to call `go run ...` on wormhole-william submodule
      testRecvTextGo(code);
    });
  }

  String testSendTextGo(String code) {
    const code = "7-guitarist-revenge";

    final res = Process.run('go', [
      'run',
      '.',
      'send',
      '--code',
      code,
      // TODO: something else?
      './README.md',
    ],
      // TODO: replace with OS-agnostic path
      workingDirectory: './dart_wormhole_william/wormhole-william',
    );
    res.then((_res) {
      print(_res.stdout);
    });
    return code;
  }

  void testSendRecvTextGoDart() {
    final sender = Client();

    sender.sendText(expectedText).then((result) {
      code = result.code;
      print('Dart | client_test:96 sent $expectedText');
      result.done.then((_) {
        print('Dart | client_test:98 send done!');
      });

      testRecvTextGo(code);
    });
  }

  void testSendRecvTextDartDart() {
    final sender = Client();
    final receiver = Client();

    sender.sendText(expectedText).then((result) {
      code = result.code;
      print('sent $expectedText');
      result.done.then((_) {
        print('Dart | client_test:113 send done!');
      });

      receiver.recvText(result.code).then((String actual) {
        actualText = actual;
        print('Dart | client_test:118 receive done! actual: $actual');
      });
    });
  }
}

// # Manual testing:
// `flutter run -d linux -v -t ./integration_test/client_test.dart`
// # Automated testing:
// `flutter drive --driver=./test_driver/integration_test_driver.dart --target=./integration_test/client_test.dart`

void main() {
  // NB: uncomment for manual testing
  runApp(ClientTestWidget());

  // NB: comment for manual testing
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // NB: comment for manual testing
  // testWidgets("failing test example", (WidgetTester tester) async {
  //   ClientTestWidget testWidget = ClientTestWidget();
  //   runApp(testWidget);
  //   await tester.pumpAndSettle();
  //   testWidget.handlePress();
  //   // TODO: something more robust!
  //   sleep(Duration(seconds: 2));
  //   expect(testWidget.code, isNotEmpty);
  //   expect(testWidget.actualText, ClientTestWidget.expectedText);
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

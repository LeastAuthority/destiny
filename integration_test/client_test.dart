import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:dart_wormhole_william/client/client.dart';

class ClientTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (BuildContext context, Widget? widget) {
          return TextButton(
            child: Text("test button"),
            onPressed: handlePress,
          );
        });
  }

  void handlePress() {
    final sender = Client();
    final receiver = Client();

    const expected = 'tesing 123';
    sender.sendText(expected).then((result) {
      print('sent $expected');
      result.done.then((_) {
        print('send done!');
      });
      receiver.recvText(result.code).then((String actual) {
        print('received $actual');
      });
    });
  }
}

void main() {
  // runApp(ClientTestWidget());

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("failing test example", (WidgetTester tester) async {
    expect(2 + 2, equals(5));
  });

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

import 'package:dart_wormhole_william/client/client.dart';
import 'package:destiny/widgets/CodeInputBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/constants/app_constants.dart';
import 'dart:io';

// Use real external stage server for testing
import '../lib/main_stage_la.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('intro slider is displayed', (tester) async {
      app.main();

      // Pass initial splash screens
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      // Check if the intro slider is displayed
      expect(find.textContaining(END_TO_END_ENCRYPTION), findsOneWidget);

      // Click on next button to go to next page
      Finder next = find.textContaining(NEXT);
      await tester.tap(next);
      await tester.pumpAndSettle();

      // Verify if No sign up slide displayed
      expect(find.textContaining(NO_SIGN_UP), findsOneWidget);

      // Click on next button to go to next page
      next = find.textContaining(NEXT);
      await tester.tap(next);
      await tester.pumpAndSettle();

      // Verify if No sign up slide displayed
      expect(find.textContaining(DEVICE_TO_DEVICE), findsOneWidget);

      // Click on agree checkbox
      Finder agreeCheckbox = find.byType(Checkbox);
      await tester.tap(agreeCheckbox);

      // Click final get started button
      next = find.textContaining(GET_STARTED);
      await tester.tap(next);
      await tester.pumpAndSettle();

      // Check if Send page is opened
      expect(
          find.textContaining(SEND_FILES_SIMPLE_SECURE_FAST,
              findRichText: true),
          findsOneWidget);
    });

    testWidgets('select file', (tester) async {
      app.main();

      // Pass initial splash screens
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      expect(
          find.textContaining(SEND_FILES_SIMPLE_SECURE_FAST,
              findRichText: true),
          findsOneWidget);

      // Click on next button to go to next page
      final Finder selectFile = find.textContaining(SELECT_A_FILE);

      // Emulate a tap on the floating action button.
      await tester.tap(selectFile);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // In case Android permission dialog is displayed
      //final Finder allow = find.textContaining("Allow");
      // Check if allow finds any widget
      // if (allow.evaluate().isNotEmpty) {
      //   await tester.tap(allow);
      //   await tester.pumpAndSettle();
      // }

      // Alternative: https://github.com/leancodepl/patrol

      // tester.allWidgets.forEach((element) {
      //   print(element);
      // });
      // sleep(Duration(seconds: 5));
    }, skip: true);
    final originalOnError = FlutterError.onError!;

    testWidgets('receive file, incorrect code', (tester) async {
      // Override FlutterError.onError to catch library error
      FlutterError.onError = (FlutterErrorDetails data) {
        if (data.exception is FlutterError) {
          final fErr = data.exception as FlutterError;
          if (fErr.message == '...') {
            print("FLUTTER MATCH ERR");
            // do not forward to presentError
            //return;
          } else {
            print("FLUTTER ERR");
            return;
          }
        } else if (data.exception.toString() ==
            "Error code: 7. Nameplate is unclaimed: 1000") {
          print("WORMHOLE ERR");
          //FlutterError.presentError(data);
          originalOnError(data);
          return;
        } else {
          //originalOnError(data);
          print("OTHER ERR:" + data.exception.toString());
          return;
        }
      };
      //tester.takeException();
      app.main();
      // Pass initial splash screens
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      expect(
          find.textContaining(SEND_FILES_SIMPLE_SECURE_FAST,
              findRichText: true),
          findsOneWidget);

      // Click on next button to go to next page
      final Finder receive = find.textContaining(RECEIVE);

      // Emulate a tap on the floating action button.
      await tester.tap(receive);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Check if received is opened
      expect(
          find.textContaining(ENTER_THE_CODE_IN_ORDER_TO_RECEIVE_THE_FILE,
              findRichText: true),
          findsOneWidget);

      // Find code input fielad
      final Finder input = find.byType(CodeInputBox);
      //final Finder code = find.textContaining(ENTER_CODE);
      await tester.enterText(input, "1000-b-c");
      await tester.pumpAndSettle();

      // Click on next button to submit code
      final Finder next = find.textContaining(NEXT, findRichText: true);

      await tester.tap(next);
      await tester.pump();
      await tester.pump();
      sleep(Duration(seconds: 5));
      await tester.pump();
      //await tester.pumpAndSettle();

      // Check if correct error displayed
      //find.textContaining("rrrr", findRichText: true),

      expect(
          find.textContaining(SOMETHING_WENT_WRONG_POSSIBLY,
              findRichText: true),
          findsOneWidget);
    });
  });
}

import 'package:destiny/widgets/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("stringValidator:", () {
    test('check null value', () {
      final result = stringValidator(null);

      expect(result, "Enter any text");
    });
    test('check empty value', () {
      final result = stringValidator("");

      expect(result, "Enter any text");
    });
    test('check too long value', () {
      final result = stringValidator("a" * 101);

      expect(result, "Please do not enter more than 100 characters here");
    });
  });

  group("uriStringValidator:", () {
    test('check null value', () {
      final result = uriStringValidator(null);

      expect(result, "Enter any text");
    });
    test('check empty value', () {
      final result = uriStringValidator("");

      expect(result, "Enter any text");
    });
    test('check too long value', () {
      final result = stringValidator("a" * 101);

      expect(result, "Please do not enter more than 100 characters here");
    });
    test('pass valid URI', () {
      final result = uriStringValidator("wss://foo.bar/baz");

      expect(result, null);
    });
    test('fail invalid URI', () {
      final result = uriStringValidator("foo");

      expect(result, "<scheme> should be one of wss, tcp");
    });
  });
}

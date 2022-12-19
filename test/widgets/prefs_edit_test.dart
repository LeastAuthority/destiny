import 'dart:ui';

import 'package:destiny/config/theme/custom_theme.dart';
import 'package:destiny/widgets/prefs_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

void main() {
  late StreamingSharedPreferences streamingSharedPreferences;

  const key = "test";
  const originalValue = "value";

  const titleKey = Key("entryTitle");
  const valueKey = Key("entryValue");
  const editKey = Key("entryEditButton");
  const firstDefaultKey = Key("default0");
  const secondDefaultKey = Key("default1");
  const okKey = Key("ok");
  const cancelKey = Key("cancel");

  late Preference<String> prefs;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({key: originalValue});
    streamingSharedPreferences = await StreamingSharedPreferences.instance;
    prefs = streamingSharedPreferences.getString(key, defaultValue: "default");
  });

  setUp(() => {prefs.setValue(originalValue)});

  group('EditableStringPrefs Widget Test:', () {
    testWidgets('has a title and value', (tester) async {
      const title = "Title";

      await tester.pumpWidget(testApp(EditableStringPrefs(
        prefs,
        title: title,
      )));

      final titleFinder = find.byKey(titleKey);
      final valueFinder = find.byKey(valueKey);
      final editFinder = find.byKey(editKey);

      expect(valueFinder, findsOneWidget);
      expect(editFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('allows editing value', (tester) async {
      const title = "Title";

      await tester.pumpWidget(testApp(EditableStringPrefs(
        prefs,
        title: title,
      )));

      await tester.tap(find.byKey(editKey));

      await tester.pump();

      final field = find.byKey(Key("formField"));
      final submit = find.byKey(Key("ok"));

      await tester.enterText(field, "update");

      await tester.tap(submit);

      assert(prefs.getValue() == "update");
    });

    testWidgets('allows setting default value', (tester) async {
      const title = "Title";

      await tester.pumpWidget(testApp(EditableStringPrefs(
        prefs,
        title: title,
      )));

      await tester.tap(find.byKey(editKey));

      await tester.pump();

      final firstDefault = find.byKey(firstDefaultKey);
      final submit = find.byKey(okKey);

      await tester.tap(firstDefault);

      final field = find.byKey(Key("formField"));
      TextFormField entry = tester.firstWidget(field);
      assert(entry.controller?.value.text == "default");

      await tester.tap(submit);

      assert(prefs.getValue() == "default");
    });

    testWidgets('handles multiple default values', (tester) async {
      const title = "Title";

      await tester.pumpWidget(testApp(EditableStringPrefs(
        prefs,
        title: title,
        expandDefaults: (value) => ["${value}1", "${value}2"],
      )));

      await tester.tap(find.byKey(editKey));

      await tester.pump();

      final secondDefault = find.byKey(secondDefaultKey);
      final submit = find.byKey(okKey);

      await tester.tap(secondDefault);

      await tester.tap(submit);

      assert(prefs.getValue() == "default2");
    });

    testWidgets('ignores setting default value when pressing cancel',
        (tester) async {
      const title = "Title";

      await tester.pumpWidget(testApp(EditableStringPrefs(
        prefs,
        title: title,
      )));

      await tester.tap(find.byKey(editKey));

      await tester.pump();

      final firstDefault = find.byKey(firstDefaultKey);
      final cancel = find.byKey(cancelKey);

      await tester.tap(firstDefault);

      await tester.tap(cancel);

      assert(prefs.getValue() == originalValue);
    });

    testWidgets('ignores edit on pressing cancel', (tester) async {
      const title = "Title";

      await tester.pumpWidget(testApp(EditableStringPrefs(
        prefs,
        title: title,
      )));

      await tester.tap(find.byKey(editKey));

      await tester.pump();

      final field = find.byKey(Key("formField"));
      final cancel = find.byKey(cancelKey);

      await tester.enterText(field, "update");

      await tester.tap(cancel);

      assert(prefs.getValue() == originalValue);
    });
  });
}

ScreenUtilInit testApp(EditableStringPrefs widget) {
  return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      //allowFontScaling: false,
      builder: () {
        WidgetsFlutterBinding.ensureInitialized();
        return MaterialApp(
          theme: CustomTheme.darkThemeMobile,
          home: widget,
        );
      });
}

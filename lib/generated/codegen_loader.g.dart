// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "window": {
    "title": "Destiny"
  },
  "menu": {
    "settings": "Settings"
  },
  "send": {
    "title": "Send",
    "topic": "Send files simply, securely, and fast.",
    "drop_file": "Drag and drop a file"
  },
  "receive": {
    "title": "Receive",
    "topic": "Enter the code in order to receive the file.",
    "enter_code": "Enter Code Here"
  },
  "generic": {
    "select_file": "Select a File",
    "or": "or",
    "next": "Next"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}

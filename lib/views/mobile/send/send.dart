import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/CodeGeneration.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SelectAFileUI.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SendingDone.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SendingProgress.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:dart_wormhole_gui/views/shared/send.dart';
import 'package:flutter/material.dart';

class Send extends SendState {
  Send({Key? key}) : super(key: key);

  @override
  SendScreen createState() => SendScreen();
}

class SendScreen extends SendShared<Send> {
  Widget generateCodeUI() {
    return CodeGeneration(
      fileName,
      fileSize,
      code,
      currentState == SendScreenStates.CodeGenerating,
      cancelSend,
      key: Key(SEND_SCREEN_CODE_GENERATION_UI),
    );
  }

  Widget selectAFileUI() {
    return SelectAFileUI(fileSize, fileName, handleSelectFile);
  }

  Widget sendingProgress() {
    return SendingProgress(
        fileSize, fileName, totalSent, totalSize, currentTimeGetter);
  }

  Widget sendingDone() {
    return SendingDone(fileSize, fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomBar(
          path: SEND_ROUTE,
          key: Key(BOTTOM_NAV_BAR),
        ),
        appBar: CustomAppBar(
          title: SEND,
          key: Key(CUSTOM_NAV_BAR),
        ),
        body: WillPopScope(
            onWillPop: () async => false,
            child: Container(
                width: double.infinity,
                key: Key(SEND_SCREEN_BODY),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    child: widgetByState(generateCodeUI, selectAFileUI,
                        sendingDone, sendingProgress)))));
  }
}

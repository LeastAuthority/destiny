import 'package:destiny/config/routes/routes.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/views/mobile/send/widgets/CodeGeneration.dart';
import 'package:destiny/views/mobile/send/widgets/SelectAFileUI.dart';
import 'package:destiny/views/mobile/send/widgets/SendingDone.dart';
import 'package:destiny/views/mobile/send/widgets/SendingProgress.dart';
import 'package:destiny/views/mobile/widgets/ErrorUI.dart';
import 'package:destiny/views/mobile/widgets/custom-app-bar.dart';
import 'package:destiny/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:destiny/views/shared/send.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendScreen extends StatelessWidget {
  Widget generateCodeUI() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return state.widgetFromMetadata((metadata) => CodeGeneration(
            metadata.fileName!,
            metadata.fileSize!,
            state.code,
            state.currentState == SendScreenStates.CodeGenerating,
            state.cancelSend,
            key: Key(SEND_SCREEN_CODE_GENERATION_UI),
          ));
    });
  }

  Widget selectAFileUI() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return SelectAFileUI(state.handleSelectFile, state.handleSelectMedia);
    });
  }

  Widget sendingProgress() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return state.widgetFromMetadata((metadata) => SendingProgress(
          metadata.fileSize!,
          metadata.fileName!,
          state.progress.percentage,
          state.progress.remainingTimeString ??
              (state.progress.percentage - 1.0 <= 0.001
                  ? WAITING_FOR_RECEIVER
                  : THREE_DOTS),
          state.cancelFunc));
    });
  }

  Widget sendingDone() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return state.widgetFromMetadata(
          (metadata) => SendingDone(metadata.fileSize!, metadata.fileName!, () {
                state.reset();
              }));
    });
  }

  Widget sendingError() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return ErrorUI(
        errorTitle: state.errorTitle,
        errorMessage: state.errorMessage,
        error: state.error,
        actionText: SELECT_A_FILE,
        actionMedia: SELECT_A_MEDIA,
        onPressed: () {
          state.reset();
          state.handleSelectFile();
        },
        onPressedMedia: () {
          state.reset();
          state.handleSelectMedia();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SendSharedState>(builder: (context, state, _) {
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
                      child: state.widgetByState(generateCodeUI, selectAFileUI,
                          sendingError, sendingDone, sendingProgress)))));
    });
  }
}

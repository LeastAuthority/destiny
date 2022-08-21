import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/CodeGeneration.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SelectAFileUI.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SendingDone.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SendingProgress.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/AbortErrorUI.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/ErrorUI.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:dart_wormhole_gui/views/shared/send.dart';
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
      return SelectAFileUI(state.handleSelectFile);
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
        errorMessage: state.errorMessage ?? UNKNOWN_ERROR,
        error: state.error != null ? state.error : '',
        actionText: "Send a file",
        onPressed: () {
          state.reset();
          state.handleSelectFile();
        },
      );
    });
  }

  Widget transferCancelled() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return AbortErrorUI(
          handleSelectFile: state.handleSelectFile,
          text: ERR_INTERRUPTION_CANCELLATION_SENDER,
          subText: 'Send a file',
          onPressed: () {
            state.reset();
          });
    });
  }

  Widget transferRejected() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return AbortErrorUI(
          handleSelectFile: state.handleSelectFile,
          text: "$THE_TRANSFER_HAS_BEEN_CANCELLED \nthe receiver.",
          subText: 'Send a file',
          onPressed: () {
            state.reset();
          });
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
                      child: state.widgetByState(
                          generateCodeUI,
                          selectAFileUI,
                          sendingError,
                          sendingDone,
                          sendingProgress,
                          transferCancelled,
                          transferRejected)))));
    });
  }
}

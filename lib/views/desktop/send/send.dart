import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTCodeGeneration.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTErrorUI.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTSelectAFile.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTSendingDone.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTSendingProgress.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/shared/send.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

extension WidgetWrappers on Widget {
  Widget dottedParent() {
    return DottedBorder(
        dashPattern: [8, 4],
        strokeWidth: 2.0.h,
        color: CustomColors.purple,
        child: this);
  }
}

class SendScreen extends StatelessWidget {
  Widget generateCodeUI() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return state.widgetFromMetadata((metadata) {
        return DTCodeGeneration(
          metadata.fileName!,
          metadata.fileSize!,
          state.code ?? GENERATING,
          state.currentState == SendScreenStates.CodeGenerating,
          () {
            state.cancelFunc();
          },
        );
      });
    });
  }

  Widget sendingDone() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return state.widgetFromMetadata((metadata) {
        return SendingDone(metadata.fileSize!, metadata.fileName!, () {
          state.setState(() {
            state.currentState = SendScreenStates.Initial;
          });
        });
      });
    });
  }

  Widget selectAFileUI() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return DTSelectAFile(
              onFileSelected: state.handleSelectFile, onFileDropped: state.send)
          .dottedParent();
    });
  }

  Widget sendingProgress() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return state.widgetFromMetadata((metadata) {
        return DTSendingProgress(
            metadata.fileSize!,
            metadata.fileName!,
            state.progress.percentage,
            state.progress.remainingTimeString ??
                (state.progress.percentage - 1.0 <= 0.001
                    ? WAITING_FOR_RECEIVER
                    : THREE_DOTS),
            state.cancelFunc);
      });
    });
  }

  Widget sendingError() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return DTErrorUI(
          paddingTop: 80.0.h,
          text: state.errorMessage ?? "Unknown error",
          showBoxDecoration: true,
          onPressed: () {
            state.reset();
          },
          buttonTitle: 'Send a file');
    });
  }

  Widget transferCancelled() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return DTErrorUI(
          paddingTop: 80.0.h,
          showBoxDecoration: true,
          text: ERR_INTERRUPTION_CANCELLATION_SENDER,
          subText: 'Please try again.',
          onPressed: () {
            state.reset();
          },
          buttonTitle: 'Send a file');
    });
  }

  Widget transferRejected() {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return DTErrorUI(
          paddingTop: 80.0.h,
          showBoxDecoration: true,
          text: 'The transfer was cancelled by the receiver.',
          onPressed: () {
            state.reset();
          },
          buttonTitle: 'Send a file');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return Scaffold(
          appBar:
              CustomAppBar(key: Key(CUSTOM_NAV_BAR), path: DESKTOP_SEND_ROUTE),
          body: WillPopScope(
              onWillPop: () async => false,
              child: Container(
                  width: double.infinity,
                  key: Key(SEND_SCREEN_BODY),
                  padding: EdgeInsets.only(left: 125.0.w, right: 125.0.w),
                  child: Container(
                      height: double.infinity,
                      margin:
                          EdgeInsets.fromLTRB(16.0.w, 30.0.h, 16.0.w, 22.0.h),
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

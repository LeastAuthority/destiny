import 'package:destiny/config/routes/routes.dart';
import 'package:destiny/config/theme/colors.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/main.dart';
import 'package:destiny/views/desktop/send/widgets/DTCodeGeneration.dart';
import 'package:destiny/views/desktop/send/widgets/DTErrorUI.dart';
import 'package:destiny/views/desktop/send/widgets/DTSelectOrDropAFile.dart';
import 'package:destiny/views/desktop/send/widgets/DTSendingDone.dart';
import 'package:destiny/views/desktop/send/widgets/DTSendingProgress.dart';
import 'package:destiny/views/desktop/widgets/custom-app-bar.dart';
import 'package:destiny/views/shared/send.dart';
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
      return DTSelectOrDropAFile(
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
          errorTitle: state.errorTitle,
          error: state.error,
          errorMessage: state.errorMessage,
          showBoxDecoration: true,
          onPressed: () {
            state.reset();
          },
          buttonTitle: SEND_A_FILE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SendSharedState>(builder: (context, state, _) {
      return Scaffold(
          appBar:
              CustomAppBar(key: Key(CUSTOM_NAV_BAR), path: DESKTOP_SEND_ROUTE),
          body: WillPopScope(
              onWillPop: onWillPopHandler,
              child: Container(
                  width: double.infinity,
                  key: Key(SEND_SCREEN_BODY),
                  padding: EdgeInsets.only(left: 125.0.w, right: 125.0.w),
                  child: Container(
                      height: double.infinity,
                      margin:
                          EdgeInsets.fromLTRB(16.0.w, 30.0.h, 16.0.w, 22.0.h),
                      child: state.widgetByState(generateCodeUI, selectAFileUI,
                          sendingError, sendingDone, sendingProgress)))));
    });
  }
}

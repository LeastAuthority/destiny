import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/desktop/receive/widgets/DTReceiveConfirmation.dart';
import 'package:dart_wormhole_gui/views/desktop/receive/widgets/DTReceiveProgress.dart';
import 'package:dart_wormhole_gui/views/desktop/receive/widgets/DTReceivingDone.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTErrorUI.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTButtonWithBackground.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/shared/receive.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_gui/widgets/CodeInputBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReceiveScreen extends StatelessWidget {
  Widget enterCode() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return Container(
          height: double.infinity,
          margin: EdgeInsets.fromLTRB(16.0.w, 0.0, 16.0.w, 4.0.w),
          child: Column(
            children: [
              Heading(
                title: ENTER_THE_CODE_IN_ORDER_TO_RECEIVE_THE_FILE,
                textStyle: Theme.of(context).textTheme.headline1,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CodeInputBox(
                        width: 400.0,
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: state.controller,
                        codeChanged: state.codeChanged,
                        onEnterPressed: (_) {
                          state.setState(() {
                            state.receive();
                          });
                        }),
                    state.controller.text.length > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DTButtonWithBackground(
                                title: state.isRequestingConnection
                                    ? 'Please wait...'
                                    : NEXT,
                                onPressed: () {
                                  state.setState(() {
                                    state.receive();
                                  });
                                },
                                width: 150.0,
                                disabled:
                                    state.isRequestingConnection ? true : false,
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                            ],
                          )
                        : Container(
                            height: 30.0,
                          )
                  ],
                ),
              )
            ],
          ));
    });
  }

  Widget receivingDone() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return DTReceivingDone(state.fileSize!, state.fileName!, state.path!, () {
        state.setState(() {
          state.reset();
        });
      });
    });
  }

  Widget receiveError() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return DTErrorUI(
          errorTitle: state.errorTitle,
          error: state.error,
          errorMessage: state.errorMessage ?? UNKNOWN_ERROR,
          onPressed: () {
            state.reset();
          },
          buttonTitle: 'Receive a file');
    });
  }

  Widget receiveProgress() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return DTReceiveProgress(
          state.fileSize!,
          state.fileName!,
          state.progress.percentage,
          state.progress.remainingTimeString ?? "...",
          state.cancelFunc);
    });
  }

  Widget receiveConfirmation() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return DTReceiveConfirmation(state.fileName!, state.fileSize!,
          state.acceptDownload, state.rejectDownload);
    });
  }

  Widget transferCancelled() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return DTErrorUI(
          errorTitle: ERR_INTERRUPTION_CANCELLATION_RECEIVER,
          error: state.error != null ? state.error : '',
          errorMessage: state.errorMessage ?? UNKNOWN_ERROR,
          onPressed: () {
            state.reset();
          },
          buttonTitle: 'Receive a file');
    });
  }

  Widget transferRejected() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return DTErrorUI(
          errorTitle: 'The transfer was cancelled by the receiver.',
          error: state.error != null ? state.error : '',
          errorMessage: state.errorMessage,
          onPressed: () {
            state.reset();
          },
          buttonTitle: 'Receive a file');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return Scaffold(
          appBar: CustomAppBar(key: Key(CUSTOM_NAV_BAR), path: RECEIVE_ROUTE),
          body: WillPopScope(
              onWillPop: () async => false,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 125.0.w, right: 125.0.w),
                child: Container(
                  margin: EdgeInsets.fromLTRB(16.0.w, 30.0.h, 16.0.w, 22.0.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dialogBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: Border.all(width: 2.0, color: CustomColors.purple),
                  ),
                  width: double.infinity,
                  key: Key(SEND_SCREEN_BODY),
                  padding:
                      EdgeInsets.only(left: 8.0.w, right: 8.0.w, top: 80.0.h),
                  child: state.widgetByState(
                      receivingDone,
                      receiveError,
                      receiveProgress,
                      enterCode,
                      receiveConfirmation,
                      transferCancelled,
                      transferRejected),
                ),
              )));
    });
  }
}

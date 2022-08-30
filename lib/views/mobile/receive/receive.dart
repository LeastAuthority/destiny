import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/EnterCode.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/ReceiveConfirmation.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/ReceiveProgress.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/ReceivingDone.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/ErrorUI.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:dart_wormhole_gui/views/shared/receive.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceiveScreen extends StatelessWidget {
  Widget receivingDone() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return ReceivingDone(state.fileSize!, state.fileName!, state.path!, () {
        state.reset();
      });
    });
  }

  Widget receiveProgress() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return ReceiveProgress(
          state.fileSize!,
          state.fileName!,
          state.progress.percentage,
          state.progress.remainingTimeString ?? THREE_DOTS,
          state.cancelFunc);
    });
  }

  Widget receiveConfirmation() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return ReceiveConfirmation(state.fileName!, state.fileSize!,
          state.acceptDownload, state.rejectDownload);
    });
  }

  Widget enterCodeUI() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return Column(
        key: Key(RECEIVE_SCREEN_CONTENT),
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Heading(
              title: ENTER_THE_CODE_IN_ORDER_TO_RECEIVE_THE_FILE,
              textAlign: TextAlign.left,
              marginTop: 0,
              textStyle: Theme.of(context).textTheme.headline6,
              key: Key(RECEIVE_SCREEN_HEADING),
            ),
          ),
          Expanded(
              flex: 2,
              child: EnterCode(
                  key: Key(RECEIVE_SCREEN_ENTER_CODE),
                  codeChanged: state.codeChanged,
                  isRequestingConnection: state.isRequestingConnection,
                  controller: state.controller,
                  handleNextClicked: () {
                    state.setState(() {
                      state.receive();
                    });
                  },
                  onEnterPressed: (_) {
                    state.setState(() {
                      state.receive();
                    });
                  }))
        ],
      );
    });
  }

  Widget receiveError() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return ErrorUI(
        errorTitle: state.errorTitle,
        errorMessage: state.errorMessage,
        error: state.error,
        actionText: RECEIVE_A_FILE,
        onPressed: () {
          state.reset();
        },
      );
    });
  }

  Widget transferCancelledOrRejected() {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return ErrorUI(
        onPressed: () {
          state.reset();
        },
        error: state.error,
        errorTitle: state.errorTitle,
        actionText: RECEIVE_A_FILE);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiveSharedState>(builder: (context, state, _) {
      return Scaffold(
          bottomNavigationBar: CustomBottomBar(
            path: RECEIVE_ROUTE,
            key: Key(BOTTOM_NAV_BAR),
          ),
          appBar: CustomAppBar(
            title: RECEIVE,
            key: Key(CUSTOM_NAV_BAR),
          ),
          body: WillPopScope(
            onWillPop: () async => false,
            child: Container(
                key: Key(RECEIVE_SCREEN_BODY),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: state.widgetByState(
                    receivingDone,
                    receiveError,
                    receiveProgress,
                    enterCodeUI,
                    receiveConfirmation,
                    transferCancelledOrRejected)),
          ));
    });
  }
}

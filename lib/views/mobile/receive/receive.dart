import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/EnterCode.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/ReceiveConfirmation.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/ReceiveProgress.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/ReceivingDone.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';

import '../../shared/receive.dart';

class Receive extends ReceiveState {
  Receive(config, {Key? key}) : super(config, key: key);

  @override
  ReceiveScreen createState() => ReceiveScreen(config);
}

class ReceiveScreen extends ReceiveShared<Receive> {
  ReceiveScreen(Config config) : super(config);

  Widget receivingDone() {
    return ReceivingDone(fileSize, fileName, path!);
  }

  Widget receiveProgress() {
    return ReceiveProgress(fileSize, fileName, progress.percentage,
        progress.remainingTimeString ?? THREE_DOTS);
  }

  Widget receiveConfirmation() {
    return ReceiveConfirmation(
        fileName, fileSize, acceptDownload, rejectDownload);
  }

  Widget enterCodeUI() {
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
                codeChanged: codeChanged,
                controller: controller,
                handleNextClicked: () {
                  this.setState(() {
                    receive();
                  });
                }))
      ],
    );
  }

  Widget receiveError() {
    return Column(
      children: [
        Heading(title: "ERROR"),
        Heading(title: errorMessage ?? "Unknown error"),
        Heading(title: "Stacktrace: ${stacktrace?.toString()}")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: widgetByState(receivingDone, receiveError, receiveProgress,
                  enterCodeUI, receiveConfirmation)),
        ));
  }
}

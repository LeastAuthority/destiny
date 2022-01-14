import 'dart:io';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/EnterCode.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/ReceivingDone.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/ReceiveProgress.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:flutter/material.dart';
import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import '../../shared/receive.dart';

class Receive extends ReceiveState {
  Receive({Key? key}) : super(key: key);

  @override
  ReceiveScreen createState() => ReceiveScreen();
}

class ReceiveScreen extends ReceiveShared<Receive> {
  Client client = Client();

  Widget receivingDone() {
    return ReceivingDone(fileSize, fileName);
  }

  Widget receiveProgress() {
    return ReceiveProgress(fileSize, fileName, totalReceived, totalSize);
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
            textStyle: Theme.of(context).textTheme.bodyText1,
            key: Key(RECEIVE_SCREEN_HEADING),
          ),
        ),
        Expanded(
            flex: 2,
            child: EnterCode(
                key: Key(RECEIVE_SCREEN_ENTER_CODE),
                codeChanged: codeChanged,
                handleNextClicked: receive))
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
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: widgetByState(receivingDone, receiveProgress, enterCodeUI)),
    ));
  }
}

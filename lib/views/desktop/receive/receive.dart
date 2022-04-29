import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTButtonWithBackground.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_gui/widgets/CodeInputBox.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../shared/receive.dart';
import '../../desktop/receive/widgets/DTReceivingDone.dart';
import '../../desktop/receive/widgets/DTReceiveProgress.dart';
import '../../desktop/receive/widgets/DTReceiveConfirmation.dart';
import '../send/widgets/DTErrorUI.dart';

final TextEditingController controller = new TextEditingController();

class Receive extends ReceiveState {
  Receive(Config config, {Key? key}) : super(config, key: key);

  @override
  _ReceiveState createState() => _ReceiveState(config);
}

class _ReceiveState extends ReceiveShared<Receive> {
  _ReceiveState(Config config) : super(config);

  Widget enterCode() {
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
                      controller: controller,
                      codeChanged: codeChanged),
                  controller.text.length > 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DTButtonWithBackground(
                              title: isRequestingConnection
                                  ? 'Please wait...'
                                  : NEXT,
                              onPressed: () {
                                setState(() {
                                  receive();
                                });
                              },
                              width: 150.0,
                              disabled: isRequestingConnection ? true : false,
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
  }

  Widget receivingDone() {
    return DTReceivingDone(fileSize, fileName, path!);
  }

  Widget receiveError() {
    return DTErrorUI(
        text: errorMessage ?? "Unknown error",
        route: RECEIVE_ROUTE,
        buttonTitle: 'Receive a file');
  }

  Widget receiveProgress() {
    return DTReceiveProgress(fileSize, fileName, progress.percentage,
        progress.remainingTimeString ?? "...", cancelFunc);
  }

  Widget receiveConfirmation() {
    return DTReceiveConfirmation(
        fileName, fileSize, acceptDownload, rejectDownload);
  }

  Widget transferCancelled() {
    return DTErrorUI(
        text: 'The transfer was interrupted.',
        subText: 'Please try again.',
        route: RECEIVE_ROUTE,
        buttonTitle: 'Receive a file');
  }

  Widget transferRejected() {
    return DTErrorUI(
        text: 'The transfer was cancelled by the receiver.',
        route: RECEIVE_ROUTE,
        buttonTitle: 'Receive a file');
  }

  @override
  Widget build(BuildContext context) {
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
                child: widgetByState(
                    receivingDone,
                    receiveError,
                    receiveProgress,
                    enterCode,
                    receiveConfirmation,
                    transferCancelled,
                    transferRejected),
              ),
            )));
  }
}

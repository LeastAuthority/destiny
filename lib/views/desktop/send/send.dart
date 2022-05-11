import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTCodeGeneration.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTErrorUI.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTSelectAFile.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTSendingProgress.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/shared/send.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../desktop//send/widgets/DTSendingDone.dart';

extension WidgetWrappers on Widget {
  Widget dottedParent() {
    return DottedBorder(
        dashPattern: [8, 4],
        strokeWidth: 2.0.h,
        color: CustomColors.purple,
        child: this);
  }
}

class Send extends SendState {
  Send(config, {Key? key}) : super(config, key: key);

  @override
  SendScreen createState() => SendScreen(config);
}

class SendScreen extends SendShared<Send> {
  SendScreen(Config config) : super(config);

  Widget generateCodeUI() {
    return widgetFromMetadata((metadata) {
      return DTCodeGeneration(
        metadata.fileName!,
        metadata.fileSize!,
        code ?? GENERATING,
        currentState == SendScreenStates.CodeGenerating,
        () {
          cancelFunc();
        },
      );
    });
  }

  Widget sendingDone() {
    return widgetFromMetadata((metadata) {
      return SendingDone(metadata.fileSize!, metadata.fileName!);
    });
  }

  Widget selectAFileUI() {
    return DTSelectAFile(onFileSelected: handleSelectFile, onFileDropped: send)
        .dottedParent();
  }

  Widget sendingProgress() {
    return widgetFromMetadata((metadata) {
      return DTSendingProgress(
          metadata.fileSize!,
          metadata.fileName!,
          progress.percentage,
          progress.remainingTimeString ??
              (progress.percentage - 1.0 <= 0.001
                  ? WAITING_FOR_RECEIVER
                  : THREE_DOTS),
          cancelFunc);
    });
  }

  Widget sendingError() {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(width: 2.0),
        ),
        child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: CustomColors.purple, width: 2.0)),
            child: Column(
              children: [
                Heading(
                  title: errorTitle,
                  marginTop: 80.0.h,
                  textStyle: TextStyle(
                      fontFamily: MONTSERRAT_MEDIUM,
                      fontSize: 25.0,
                      color: Theme.of(context).textTheme.bodyText1?.color),
                ),
                Heading(
                  title: error.toString(),
                  textStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText1?.fontFamily,
                      color: Theme.of(context).textTheme.bodyText1?.color),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: Border.all(
                        width: 2.0, color: CustomColors.superLightBlack),
                  ),
                  padding: EdgeInsets.fromLTRB(50.0, 8.0, 50.0, 8.0),
                  child: Expanded(
                      // flex: 1,
                      child: Container(
                          // constraints: BoxConstraints (
                          //   minHeight: 50.0,
                          //   maxHeight: 400.0,
                          // ),
                          // width: 600.0,
                          // height: 800.0.h,
                          child: SingleChildScrollView(
                            child: Text(
                              errorMessage ?? "Unknown error",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Theme.of(context).textTheme.headline5?.color,
                                fontSize: 12.0,
                              ),
                            ),
                          ))),
                ),
                // SizedBox(
                //   height: 70.0,
                // ),
                // DTButtonWithBackground(
                //   onPressed: () {
                //     Navigator.pushReplacementNamed(
                //       context,
                //       DESKTOP_SEND_ROUTE,
                //     );
                //   },
                //   title: "Send a file",
                //   width: 150.0,
                //   disabled: false,
                // )
              ],
            )));
    // return DTErrorUI(
    //     paddingTop: 80.0.h,
    //     text: errorMessage ?? "Unknown error",
    //     showBoxDecoration: true,
    //     route: DESKTOP_SEND_ROUTE,
    //     buttonTitle: 'Send a file');
  }

  Widget transferCancelled() {
    return DTErrorUI(
        paddingTop: 80.0.h,
        showBoxDecoration: true,
        text: 'The transfer was interrupted.',
        subText: 'Please try again.',
        route: DESKTOP_SEND_ROUTE,
        buttonTitle: 'Send a file');
  }

  Widget transferRejected() {
    return DTErrorUI(
        paddingTop: 80.0.h,
        showBoxDecoration: true,
        text: 'The transfer was cancelled by the receiver.',
        route: DESKTOP_SEND_ROUTE,
        buttonTitle: 'Send a file');
  }

  @override
  Widget build(BuildContext context) {
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
                    margin: EdgeInsets.fromLTRB(16.0.w, 30.0.h, 16.0.w, 22.0.h),
                    child: widgetByState(
                        generateCodeUI,
                        selectAFileUI,
                        sendingError,
                        sendingDone,
                        sendingProgress,
                        transferCancelled,
                        transferRejected)))));
  }
}

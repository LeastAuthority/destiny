import 'package:cross_file/cross_file.dart';
import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widget/DTCodeGeneration.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widget/DTSelectAFile.dart';
import 'package:dart_wormhole_gui/views/desktop/send/widget/DTSendingProgress.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/shared/send.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return DTCodeGeneration(
      fileName: fileName,
      fileSize: fileSize,
      code: code ?? GENERATING,
      isCodeGenerating: currentState == SendScreenStates.CodeGenerating,
      // cancelSend,
      key: Key(SEND_SCREEN_CODE_GENERATION_UI),
    );
  }

  Widget sendingDone() {
    return DTSendingProgress(fileSize, fileName, progress.percentage,
        progress.remainingTimeString ?? THREE_DOTS);
  }

  Widget selectAFileUI() {
    return DTSelectAFile(
        handleSelectFile: handleSelectFile,
        handleFileDroped: (XFile file) async {
          PlatformFile platformFile = PlatformFile(
              name: file.name, size: await file.length(), path: file.path);
          send(platformFile);
        }).dottedParent();
  }

  Widget sendingProgress() {
    return DTSendingProgress(fileSize, fileName, progress.percentage,
        progress.remainingTimeString ?? THREE_DOTS);
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
                    child: widgetByState(generateCodeUI, selectAFileUI,
                        sendingDone, sendingProgress)))));
  }
}

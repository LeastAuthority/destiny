import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/CodeGeneration.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SelectAFileUI.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SendingDone.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SendingProgress.dart';
import 'package:dart_wormhole_gui/views/shared/shared.dart';
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
  Send({Key? key}) : super(key: key);

  @override
  SendScreen createState() => SendScreen();
}

class SendScreen extends SendShared<Send> {
  Widget generateCodeUI() {
    return CodeGeneration(
      isCodeGenerating: currentState == SendScreenStates.CodeGenerating,
      fileName: fileName,
      fileSize: fileSize,
      code: code ?? '',
      key: Key(SEND_SCREEN_CODE_GENERATION_UI),
    ).dottedParent();
  }

  Widget sendingDone() {
    return SendingDone(fileSize, fileName);
  }

  Widget selectAFileUI() {
    return SelectAFileUI(fileSize, fileName, code ?? '', handleSelectFile);
  }

  Widget sendingProgress() {
    return SendingProgress(fileSize, fileName);
  }

  @override
  Widget build(BuildContext context) {
    print("Current state is: $currentState");
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

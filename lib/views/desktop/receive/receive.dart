import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTButtonWithBackground.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_gui/widgets/CodeInputBox.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';

import '../../shared/receive.dart';

final TextEditingController controller = new TextEditingController();

class Receive extends ReceiveState {
  Receive(Config config, {Key? key}) : super(config, key: key);

  @override
  _ReceiveState createState() => _ReceiveState(config);
}

class _ReceiveState extends ReceiveShared<Receive> {
  String code = "";

  _ReceiveState(Config config) : super(config);

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
                padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                child: Container(
                    height: double.infinity,
                    margin: EdgeInsets.fromLTRB(16.0.w, 0.0, 16.0.w, 4.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Heading(
                          title: ENTER_THE_CODE_IN_ORDER_TO_RECEIVE_THE_FILE,
                          textStyle: Theme.of(context).textTheme.headline1,
                        ),
                        CodeInputBox(
                            width: 400.0.w,
                            controller: controller,
                            codeChanged: (String code) {
                              controller.text = code;
                              this.setState(() {
                                code = code;
                              });
                            }),
                        controller.text.length > 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DTButtonWithBackground(
                                    title: NEXT,
                                    handleSelectFile: () {},
                                    width: 100.0.w,
                                  ),
                                  SizedBox(
                                    width: 15.0.w,
                                  ),
                                ],
                              )
                            : Container(
                                height: 30.0.h,
                              )
                      ],
                    )),
              ),
            )));
  }
}

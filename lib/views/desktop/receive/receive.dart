import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTButton.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTButtonWithBackground.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';

final TextEditingController controller = new TextEditingController();

class Receive extends StatefulWidget {
  Receive({Key? key}) : super(key: key);
  @override
  _ReceiveState createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
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
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border(
                    top: BorderSide(width: 2.0, color: CustomColors.purple),
                    left: BorderSide(width: 2.0, color: CustomColors.purple),
                    right: BorderSide(width: 2.0, color: CustomColors.purple),
                    bottom: BorderSide(width: 2.0, color: CustomColors.purple),
                  ),
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
                        SizedBox(
                          width: 400.0.w,
                          height: 60.0.h,
                          child: TextField(
                            controller: controller,
                            onChanged: (text) {
                              this.setState(() {});
                            },
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context).textTheme.bodyText1,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: CustomColors.purple, width: 1.0),
                              ),

                              hintText: ENTER_CODE,
                            ),
                          ),
                        ),
                        controller.text.length > 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DTButtonWithBackground(
                                    title: NEXT,
                                    handleSelectFile: () {},
                                  ),
                                  SizedBox(
                                    width: 15.0.w,
                                  ),
                                  DTButton(CANCEL, () {}),
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

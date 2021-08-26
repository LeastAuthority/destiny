import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/widgets/CodeGeneration.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';
import 'package:dart_wormhole_gui/widgets/SendingProgress.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dart_wormhole_william/client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom-app-bar.dart';
import '../widgets/custom-bottom-bar.dart';
import '../widgets/ButtonWithIcon.dart';
import '../constants/api_path.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    void test () {
      print(ModalRoute.of(context));
    }
    return Scaffold(
        bottomNavigationBar:  CustomBottomBar(
             path: SEND_ROUTE,
             key: Key(BOTTOM_NAV_BAR),
        ),
        appBar: CustomAppBar(
            title:SETTINGS,
            key:Key(CUSTOM_NAV_BAR),
        ),
        backgroundColor: Color(0xff1A1C2E),
        body: Container(
          width: double.infinity,
          key: Key(SEND_SCREEN_BODY),
          padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
          child: Column(
                    key: Key(SEND_SCREEN_CONTENT),
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Column(
                          children: [
                            Heading(
                              title: SELECT_DEFAULT_SAVE_DESTINATION_FOR_THIS_DEVICE,
                              textAlign: TextAlign.left,
                              marginTop:0,
                              fontSize: 14.sp,
                              fontFamily: LATO,
                              fontWeight: FontWeight.w300,
                              key: Key(SEND_SCREEN_HEADING),
                            ),
                            Heading(
                              title: '${CURRENT_SAVE_DESTINATION}',
                              subTitle: ' Destiny Received',
                              textAlign: TextAlign.left,
                              marginTop:14.0.w,
                              fontSize: 14.sp,
                              fontFamily: LATO,
                              fontWeight: FontWeight.w300,
                              // key: Key(SEND_SCREEN_HEADING),
                            )
                          ],
                        ),
                        ButtonWithIcon(
                            label:SELECT_A_FILE,
                            handleSelectFile: (){},
                            icon: null,
                            height:60.0.h,
                            width: 200.0.w,
                            isVertical: false,
                            key:Key(SEND_SCREEN_SELECT_A_FILE_BUTTON)
                        ),
                      SizedBox(
                        key:Key(SEND_SCREEN_BOTTOM_SPACE_PLACEHOLDER),
                        height: 100.h,
                      ),
                    ]
                ),

    ));
  }
}

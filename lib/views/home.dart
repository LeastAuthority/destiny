import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/widgets/GridButtons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom-app-bar.dart';
import '../widgets/custom-bottom-bar.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final keyCounter = GlobalKey<_HomeState>();
  selecteFile () async
  {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    print(result);
    print("Paaaat");
    if(result != null)
      print(result.files.single.path!);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      key: Key(HOME_SCAFFOLD),
      appBar: CustomAppBar(HOME),
      backgroundColor: Color(0xff1A1C2E),
      body: Container(
        key: Key(HOME_MAIN_CONTAINER),
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Heading(
              title: SEND_AND_RECEIVE_FILES_SECURLY_AND_FAST,
              textAlign: TextAlign.left,
              marginTop:0.0,
              fontSize: 18.sp,
              key:  Key(HOME_MAIN_HEADING),
            ),
            GridButtons(),
            SizedBox(
              height: 100.h,
            ),
          ],
        ),
      ),
      bottomNavigationBar:  CustomBottomBar(),
    );
  }
}

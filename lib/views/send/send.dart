import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/send/widgets/CodeGeneration.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';
import 'package:dart_wormhole_gui/views/send/widgets/SendingProgress.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dart_wormhole_william/client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/custom-app-bar.dart';
import '../../widgets/custom-bottom-bar.dart';
import '../../widgets/buttons/ButtonWithIcon.dart';
import '../../constants/api_path.dart';
class SendDefault extends StatefulWidget {
  SendDefault({Key? key}) : super(key: key);
  @override
  _SendDefaultState createState() => _SendDefaultState();
}

class _SendDefaultState extends State<SendDefault> {
  String _msg = 'test test';
  String _code = 'sssssssssssssss';
  String fileName = '';
  int fileSize = 0;
  TextEditingController _codeTxtCtrl = TextEditingController();

  Client client = Client();

  void _msgChanged(String msg) {
    setState(() {
      _msg = msg;
    });
  }

  void _codeChanged(String code) {
    setState(() {
      _code = code;
    });
  }

  void _send(String name) {
    // String code = client.sendText(name);
    // _codeTxtCtrl.text = code;
    // setState(() {
    //   _code = code;
    // });
  }

  void handleSelectFile () async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(result != null) {
      PlatformFile file = result.files.first;
      //FIXME
      //Here we should have a call to a function that generate and returns wormhole code.
      //When we have the code, we set it to the state below so user can see it in the UI.
      _send(file.name);
      setState(() {
        fileName = file.name;
        fileSize = (file.size/8).toInt(); //bytes to kb
      });
      // print("filenameeeeeee");
      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
    } else {
      // User canceled the picker
    }
  }

  Widget getCodeGenerationUI () {
    if(fileSize > 0)
        return CodeGeneration(
          fileName: fileName,
          fileSize: fileSize,
          code: _code,
          key: Key(SEND_SCREEN_CODE_GENERATION_UI),
        );

      return ButtonWithIcon(
          label:SELECT_A_FILE,
          handleSelectFile:handleSelectFile,
          icon:Image.asset(
            PHONE_ICON,
            width: 30.0.w,
          ),
        height:60.0.h,
        width: 200.0.w,
        isVertical: false,
        key:Key(SEND_SCREEN_SELECT_A_FILE_BUTTON)
      );

      //Warning!! Don't delete next 2 comment
    return SendingProgress(fileSize, fileName); //change params
   // return SentSuccessfully(fileSize, fileName);
  }
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
            title:SEND,
            key:Key(CUSTOM_NAV_BAR),
        ),
        backgroundColor: Color(0xff1A1C2E),
        body: WillPopScope(
        onWillPop: () async => false,
        child:Container(
          width: double.infinity,
          key: Key(SEND_SCREEN_BODY),
          padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
          child: Column(
                    key: Key(SEND_SCREEN_CONTENT),
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Heading(
                        title: SEND_AND_RECEIVE_FILES_SECURLY_AND_FAST,
                        textAlign: TextAlign.left,
                        marginTop:0,
                        fontSize: 14.sp,
                        fontFamily: LATO,
                        fontWeight: FontWeight.w300,
                        key: Key(SEND_SCREEN_HEADING),
                      ),
                      getCodeGenerationUI(),
                      SizedBox(
                        key:Key(SEND_SCREEN_BOTTOM_SPACE_PLACEHOLDER),
                        height: fileSize > 0? 0.h:100.h,
                      ),
                    ]
                ),

    )));
  }
}

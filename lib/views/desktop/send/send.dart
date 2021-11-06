import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/CodeGeneration.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SelectAFileUI.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';


class Send extends StatefulWidget {
  Send({Key? key}) : super(key: key);
  @override
  _SendDefaultState createState() => _SendDefaultState();
}

class _SendDefaultState extends State<Send> {
  String _msg = 'test test';
  String _code = 'sssssssssssssss';
  String fileName = '';
  int fileSize = 0;
  TextEditingController _codeTxtCtrl = TextEditingController();

  // Client client = Client();

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
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            key:Key(CUSTOM_NAV_BAR),
            path: SEND_ROUTE
        ),
        body: WillPopScope(
        onWillPop: () async => false,
        child:Container(
          width: double.infinity,
          key: Key(SEND_SCREEN_BODY),
          padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
          child: Container (
            height:  double.infinity,
            margin: EdgeInsets.fromLTRB(16.0.w, 0.0, 16.0.w, 4.0.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2.0, color: CustomColors.purple),
                  top: BorderSide(width: 2.0, color: CustomColors.purple),
                  left: BorderSide(width: 2.0, color: CustomColors.purple),
                  right: BorderSide(width: 2.0, color: CustomColors.purple),
                ),
              ),
            child: Text('dddddsdasdddd'),
          )
        )
        )
    );
  }
}

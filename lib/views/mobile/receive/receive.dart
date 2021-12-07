import 'dart:io';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/EnterCode.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/ReceivingDone.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/receive/widgets/ReceiveProgress.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class Receive extends StatefulWidget {
  bool isReceiving = false;
  Receive({Key? key}) : super(key: key);
  @override
  _ReceiveState createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
  String _msg = '';
  String _code = '';
  bool isReceiving = false;
  bool received = false;
  TextEditingController _msgTxtCtrl = TextEditingController();
  Client client = Client();
  SharedPreferences? prefs;
  final _chars = ROW_RANDOM_STRING;
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  void _msgChanged(String msg) {
    setState(() {
      _msg = msg;
    });
  }

  Future gePath() async {
    prefs = await SharedPreferences.getInstance();
    return prefs?.getString(PATH) ;
  }

  void _codeChanged(String code) {
    print(code);
    setState(() {
      _code = code;
    });
  }
  Future<String> getFilePath() async {
    String path = await gePath();
    String randomName = getRandomString(10);
    String filePath = '$path/$randomName.png';
    return filePath;
  }

  void _receive() async {
    String? path =  await gePath();
    print(path);
    if(path != null) {
      client.recvFile(_code).then((result) async {
        File file = File(path);
        file.writeAsBytes(result);
        this.setState(() {
          received = true;
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(MUST_CHOOSE_PATH_TO_SAVE_THE_FILE),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: CustomBottomBar(
        path: RECEIVE_ROUTE,
        key: Key(BOTTOM_NAV_BAR),
      ),
      appBar: CustomAppBar(
        title: RECEIVE,
        key: Key(CUSTOM_NAV_BAR),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
        key:Key(RECEIVE_SCREEN_BODY),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: received == true ?
          ReceivingDone(2, 'fileName'):
          Container (
          child : isReceiving ?
          ReceiveProgress(22, 'my picture.png'):Column (
            key:Key(RECEIVE_SCREEN_CONTENT),
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded (
                flex: 1,
                child: Heading(
                  title: ENTER_THE_CODE_IN_ORDER_TO_RECEIVE_THE_FILE,
                  textAlign: TextAlign.left,
                  marginTop: 0,
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  key:  Key(RECEIVE_SCREEN_HEADING),
                ),
              ),
            Expanded (
              flex: 2,
              child: EnterCode(
                  key: Key(RECEIVE_SCREEN_ENTER_CODE),
                  codeChanged: _codeChanged,
                  handleNextClicked: () {
                    _receive();
                    // this.setState(() {
                    //   isReceiving = true;
                    // });
                  }
              )

            )
            ],
          )),
        ),
      )
    );
  }
}
import 'package:dart_wormhole_gui/views/receive/widgets/ReceiveProgress.dart';
import 'package:flutter/material.dart';
import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/receive/widgets/EnterCode.dart';
import 'package:dart_wormhole_gui/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/widgets/custom-bottom-bar.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';

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
  TextEditingController _msgTxtCtrl = TextEditingController();

  void _msgChanged(String msg) {
    setState(() {
      _msg = msg;
    });
  }

  void _codeChanged(String code) {
    print(code);
    setState(() {
      _code = code;
    });
  }

  void _receive() {
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
        child:Container(
        key:Key(RECEIVE_SCREEN_BODY),
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: isReceiving ?
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
                  this.setState(() {
                    isReceiving = true;
                  });
                }
            ),
          )
          ],
        ),
      ),
      )
    );
  }
}
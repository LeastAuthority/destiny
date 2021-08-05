import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/widgets/Button.dart';

import '../widgets/Heading.dart';
import 'package:dart_wormhole_gui/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/widgets/custom-bottom-bar.dart';
import 'package:flutter/material.dart';
import 'package:dart_wormhole_william/client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Receive extends StatefulWidget {
  Receive({Key? key}) : super(key: key);

//  final String title;

  @override
  _ReceiveState createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
  String _msg = '';
  String _code = '';
  TextEditingController _msgTxtCtrl = TextEditingController();

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

  void _receive() {
    String msg = client.recvText(_code);
    _msgTxtCtrl.text = msg;
    setState(() {
      _msg = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  CustomBottomBar(),
      appBar: CustomAppBar(RECEIVE),
      backgroundColor: Color(0xff1A1C2E),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Heading(
              title: ENTER_THE_CODE_IN_ORDER_TO_RECEIVE_THE_FILE,
              textAlign: TextAlign.left,
              marginTop:0,
              fontSize: 14.sp,
              key:  Key('Receive_Description'),
            ),
           Container(
            alignment: Alignment.center,
           child:  Column(
               children: [
                 SizedBox(
                   width: MediaQuery.of(context).size.width - 100.0,
                   height: 150.0.h,
                   child: TextField(
                     textAlign: TextAlign.center,
                     decoration: InputDecoration(
                       hintStyle: TextStyle(fontSize: 14.0, color: Colors.white, ),
                       enabledBorder: const OutlineInputBorder(
                         borderSide: const BorderSide(color: Color(0XffC24DF8), width: 1.0),
                       ),
                       hintText: 'Enter Code',
                     ),
                   ),
                 ),
                 Button('Next', () {
                   //FIXME
                   //Here we call a function to start receiving a file. The function takes the generated code as parameter.
                   //Note that the UI here is not ready. So maybe we should pass a static code to the fun
                 }),
                 Button('Cancel', () {}),
                 // SizedBox(
                 //   height: 100.h,
                 // ),
               ],
             ),
           )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
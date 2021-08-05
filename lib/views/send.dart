import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';
import 'package:dart_wormhole_gui/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/widgets/SendingProgress.dart';
import 'package:dart_wormhole_gui/widgets/SentSuccessfully.dart';
import '../widgets/Button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dart_wormhole_william/client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom-app-bar.dart';
import '../widgets/custom-bottom-bar.dart';
import '../widgets/ButtonWithIcon.dart';

class SendDefault extends StatefulWidget {
  SendDefault({Key? key}) : super(key: key);
  @override
  _SendDefaultState createState() => _SendDefaultState();
}

class _SendDefaultState extends State<SendDefault> {
  String _msg = 'test test';
  String _code = '';
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

  void _send() {
    String code = client.sendFile(_msg);
    _codeTxtCtrl.text = code;
    setState(() {
      _code = code;
    });
  }

  void handleSelectFile () async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(result != null) {
      PlatformFile file = result.files.first;
      //FIXME
      //Here we should have a call to a function that generate and returns wormhole code.
      //When we have the code, we set it to the state below so user can see it in the UI.
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
        return Column(
          children: [
            FileInfo(fileSize, fileName),
            ButtonWithIcon('Generating Code', () {},
                CircularProgressIndicator(
                  value: 1,
                  semanticsLabel: 'Linear progress indicator',
                )),

            Heading(
                title: SHARE_CODE_WITH_RECIPIENT_AND_WAIT_UNTIL_THE_TRANSFER_IS_COMPLETE,
                textAlign:TextAlign.center,
                marginTop: 16.0.h,
                fontSize: 12.sp,
                key:Key('Generation_Description')
            ),
           Button('Cancel', () {

           })
          ],
        );

      return ButtonWithIcon(SELECT_A_FILE, ()=> handleSelectFile(),
          Image.asset(
          'assets/images/send.png',
          width: 30.0.w,
      ));

      //Warning!! Don't delete next 2 comment
    return SendingProgress(fileSize, fileName); //change params
   // return SentSuccessfully(fileSize, fileName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:  CustomBottomBar(),
        appBar: CustomAppBar(SEND),
        backgroundColor: Color(0xff1A1C2E),
        body: Container(
          padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
          child: Container(
             child: SizedBox(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Heading(
                        title: SEND_AND_RECEIVE_FILES_SECURLY_AND_FAST,
                        textAlign: TextAlign.left,
                        marginTop:0,
                        fontSize: 18.sp,
                        key: Key('Send_Description'),
                      ),
                      getCodeGenerationUI(),
                      SizedBox(
                        height: fileSize > 0? 0.h:100.h,
                      ),
                    ]
                ),
              )
          ),
    ));
  }
}


//
//
// class _SendDefaultState extends State<SendDefault> {
//   String _msg = '';
//   String _code = '';
//   TextEditingController _codeTxtCtrl = TextEditingController();
//
//   Client client = Client();
//
//   void _msgChanged(String msg) {
//     setState(() {
//       _msg = msg;
//     });
//   }
//
//   void _codeChanged(String code) {
//     setState(() {
//       _code = code;
//     });
//   }
//
//   void _send() {
//     String code = client.sendText(_msg);
//     _codeTxtCtrl.text = code;
//     setState(() {
//       _code = code;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
// //        title: Text(widget.title),
//         title: Text('Send Text'),
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 250),
// //        margin: EdgeInsets.all(100),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//                 onPressed: () => Navigator.pushReplacementNamed(context, '/r'),
//                 child: Text('Go to Receive')),
//             TextField(
//               onChanged: _msgChanged,
//             ),
//             Text(
//               '$_code',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             TextField(
//               controller: _codeTxtCtrl,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _send,
//         tooltip: 'Send',
//         child: Icon(Icons.send),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:dart_wormhole_william/client.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom-app-bar.dart';

class SendDefault extends StatefulWidget {
  SendDefault({Key? key}) : super(key: key);

//  final String title;

  @override
  _SendDefaultState createState() => _SendDefaultState();
}

class _SendDefaultState extends State<SendDefault> {
  String _msg = '';
  String _code = '';
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
    String code = client.sendText(_msg);
    _codeTxtCtrl.text = code;
    setState(() {
      _code = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1A1C2E),
        body: Container(
          child: Container(
             child: SizedBox(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text('Select the file you would like to send from your device & wait for the generated code.',
                      //   style:TextStyle(color: Colors.white, fontSize: 14.sp)
                      // ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border(
                            top: BorderSide(width: 1.0, color: Color(0xffC24DF8)),
                            left: BorderSide(width: 1.0, color: Color(0xffC24DF8)),
                            right: BorderSide(width: 1.0, color: Color(0xffC24DF8)),
                            bottom: BorderSide(width: 1.0, color: Color(0xffC24DF8)),
                          ),
                        ),
                        width: 190.0.w,
                        height: 70.0.w,
                        margin: const EdgeInsets.all(8.0),
                        child:  FlatButton(
                          onPressed: () => Navigator.pushNamed(context, '/send'),
                          color: Color(0x00353846),
                          child: Row( // Replace with a Row for horizontal icon + text
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Select a File", style:TextStyle(color: Colors.white, fontSize: 14.sp)),
                              Image.asset(
                                'assets/images/send.png',
                                width: 30.0.w,
                                // fit:BoxFit.fitHeight,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                ),
              )
            // ],
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
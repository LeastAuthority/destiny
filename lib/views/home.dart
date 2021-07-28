import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom-app-bar.dart';
import '../widgets/custom-bottom-bar.dart';

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
      appBar: CustomAppBar('Home'),
      backgroundColor: Color(0xff1A1C2E),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // CustomAppBar('Home'),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Send and receive files securely and fast',
                style:TextStyle(color: Colors.white, fontSize: 22.sp),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8.0),
                      width: 100.0.w,
                      height: 150.0.w,
                      child:  FlatButton(
                        onPressed: () => Navigator.pushNamed(context, '/receive'),
                        color: Color(0xff353846),
                        child: Column( // Replace with a Row for horizontal icon + text
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/receive.png',
                              width: 90.0.w,
                            ),
                            Text("Receive", style:TextStyle(color: Colors.white, fontSize: 16))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 100.0.w,
                      height: 150.0.w,
                      margin: const EdgeInsets.all(8.0),
                      child:  FlatButton(
                        onPressed: () => Navigator.pushNamed(context, '/send'),
                        color: Color(0xff353846),
                        child: Column( // Replace with a Row for horizontal icon + text
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/send.png',
                              width: 90.0.w,
                            ),
                            Text("Send", style:TextStyle(color: Colors.white, fontSize: 16))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 220.0.w,
                  height: 50.0.w,
                  margin: const EdgeInsets.fromLTRB(0,8.0,0,0),
                  child:  FlatButton(
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                    color: Color(0xff353846),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/send.png',
                          width: 30.0.w,
                        ),
                        Text("Settings", style:TextStyle(color: Colors.white, fontSize: 16))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.h,
                )
              ],
            )
            // FlatButton(onPressed: (){
            //   selecteFile();
            // }, child: Text('Click')),
            // Container(
            //   //Container to control width of progress bar
            //   width: 100.0,
            //   child:  LinearProgressIndicator(
            //     value: 0.2,
            //     semanticsLabel: 'Linear progress indicator',
            //     backgroundColor: Colors.purple,
            //     color: Colors.red,
            //   ),
            // )
          ],
        ),
      ),
      // ),
      bottomNavigationBar:  CustomBottomBar(),
    );
  }
}

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  CustomAppBar(this.title) : preferredSize = Size.fromHeight(85.0.h);
  //  CustomAppBar(this.title) : preferredSize = Size.fromHeight(120.0.w); tablet

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState(title);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final String title;
  _CustomAppBarState(this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                 padding: EdgeInsets.only(left:16.0.w),
                  width: MediaQuery.of(context).size.width.w / 3.0.w,
                  child:  Text('$title', style: TextStyle(fontSize: 20.0.sp, color: Colors.white),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width.w / 3.0.w,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 76.0.w,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width.w / 3.0.w,
                  alignment: Alignment.centerRight,
                  child:  FlatButton.icon(
                      label: Text(''),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => new AlertDialog(
                              content: new Text("Select the default save destination for your files on this device."),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Select'),
                                  onPressed: () {
                                    AppSettings.openDeviceSettings();
                                  },
                                )
                              ],
                            ));
                      },
                      icon: Image.asset(
                        'assets/images/send.png',
                        width: 30.0,
                      )),
                )
                // Container(
                //     width: MediaQuery.of(context).size.width.w / 3.0.w,
                //     height: 30.0.h,
                //     padding: EdgeInsets.only(right:16.0.w),
                //     child: Image.asset(
                //       'assets/images/send.png',
                //     ),
                // )
              ],
            ),
            Divider(height: 10.0, color: Colors.white),
          ],
        ),
      )
    );
  }
}

// class CustomAppBar extends StatelessWidget {
//   final String title;
//   CustomAppBar(this.title);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width / 3.0,
//                 child:  Text('$title', style: TextStyle(fontSize: 20.0.sp, color: Colors.white),),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width / 3.0,
//                 alignment: Alignment.center,
//                 child: Image.asset(
//                   'assets/images/logo.png',
//                   // width: 40.0.w,
//                   width: 76.0.w,
//                   // fit:BoxFit.fitHeight,
//                 ),
//               ),
//               // Container(
//               //   width: MediaQuery.of(context).size.width / 3.0,
//               //   child:  Text('$title', style: TextStyle(fontSize: 20.0.sp, color: Colors.black),),
//               // ),
//             ],
//           ),
//           Divider(height: 10.0, color: Colors.white),
//         ],
//       ),
//     );
//   }
// }

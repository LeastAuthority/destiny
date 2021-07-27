import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  CustomAppBar(this.title) : preferredSize = Size.fromHeight(70.0.w);
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
      child: SizedBox(
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3.0,
                  child:  Text('$title', style: TextStyle(fontSize: 20.0.sp, color: Colors.white),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3.0,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo.png',
                    // width: 40.0.w,
                    width: 76.0.w,
                    // height: 30.0.h,
                    // fit:BoxFit.fitHeight,
                  ),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width / 3.0,
                //   child:  Text('$title', style: TextStyle(fontSize: 20.0.sp, color: Colors.black),),
                // ),
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      clipBehavior: Clip.none,
      alignment:  FractionalOffset(.5, 1.2),
      children: [
        Container(
         height: (MediaQuery.of(context).size.height * 0.045).h,
          color: Color(0xff353846),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(top:32),
                  child: Image.asset(
                    'assets/images/send.png',
                    width: 30.0.w,
                    // fit:BoxFit.fitHeight,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10.0.h),
                  child: FloatingActionButton(
                    // notchMargin: 24.0,
                    backgroundColor:  Color(0xff33b4fd),
                    onPressed: () => print('hello world'),
                    child:  Icon(Icons.home, size: 40,),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:32),
                  child: Image.asset(
                    'assets/images/receive.png',
                    width: 30.0.w,
                    // fit:BoxFit.fitHeight,
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }
}

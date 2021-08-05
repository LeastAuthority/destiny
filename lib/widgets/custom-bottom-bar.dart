import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 1.0),
        color: Colors.black,
        child: Container(
        height: (MediaQuery.of(context).size.height * 0.045).h,
        color: Color(0xff353846),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: (MediaQuery.of(context).size.width * 0.4).w,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 4.0, color: Color(0xffC24DF8)),
                ),
              ),
              child: Image.asset(
                'assets/images/send.png',
                width: 30.0.w,
                // fit:BoxFit.fitHeight,
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width * 0.4).w,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 4.0, color: Color(0xffC24DF8)),
                ),
              ),
              child: Image.asset(
                'assets/images/receive.png',
                width: 30.0.w,
                // fit:BoxFit.fitHeight,
              ),
            ),
          ],
        )
    )
    );
  }
}

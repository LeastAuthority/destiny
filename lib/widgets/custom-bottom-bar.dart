import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';

class CustomBottomBar extends StatelessWidget {
  String? path;
  CustomBottomBar({Key? key, String? path}):super(key:key){
    this.path = path;
  }
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width * 0.4);
    Decoration getCurrentPath (String screen) {
      if(path == screen)
        return  BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 4.0, color: Color(0xffC24DF8)),
          ),
        );
      else if(path == screen){
        return  BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 4.0, color: Color(0xffC24DF8)),
          ),
        );
      }
      return  BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.0, color: Color(0xff353846)),
        ),
      );
    }
    return Container(
        padding: EdgeInsets.only(bottom: 1.0),
        color: Colors.black,
        child: Container(
        height: (MediaQuery.of(context).size.height * 0.060).h,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded (
              flex:1,
              child: Container(
                decoration: getCurrentPath(SEND_ROUTE),
                child: Column(
                  children: [
                    SizedBox(
                      child: FlatButton(
                          onPressed: () {
                            // isCurrentScreen(context);
                          },
                          child:  Image.asset(
                            'assets/images/send.png',
                            width: 40.0.w,
                          )),
                    ),
                    Text(
                      SEND,
                      style: TextStyle(color: Colors.white, fontFamily: LATO, fontSize: 12.sp),
                    )
                  ],
                ),
              )
            ),
            Expanded(
              flex:1,
              child: Container(
                decoration: getCurrentPath(RECEIVE_ROUTE),
                child: Column (
                  children: [
                    SizedBox(
                      // decoration: getCurrentPath('RECEIVE_SCREEN'),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/receive');
                          },
                          child:  Image.asset(
                            'assets/images/receive.png',
                            width: 40.0.w,
                          )),
                    ),
                    Text(
                      RECEIVE,
                      style: TextStyle(color: Colors.white, fontFamily: LATO, fontSize: 12.sp),
                    )
                  ],
                ),
              )
            ),
          ],
        ),
    )
    );
  }
}

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
                                content:new Text(
                                    "You are awesome!",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Color(0xff1A1C2E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  side: BorderSide(
                                      width: 1.0,
                                      color: Colors.grey
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Open settings', style:TextStyle(color: Colors.white)),
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
                ],
              ),
              Divider(height: 10.0, color: Colors.white),
            ],
          ),
        )
    );
  }
}

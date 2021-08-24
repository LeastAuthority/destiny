import 'package:app_settings/app_settings.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  String? title;
  CustomAppBar({String? title, Key? key}):super(key: key){
    this.title = title;
  }

  @override
  final Size preferredSize = Size.fromHeight(85.0.h); // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState(this.title);
}

class _CustomAppBarState extends State<CustomAppBar> {
   String? title;
  _CustomAppBarState(this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column (
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Container(
                    alignment: Alignment.centerLeft,
                    height: 60.0.h,
                    padding: EdgeInsets.only(left:8.0.w),
                    child:  Text(
                      '$title',
                      style: TextStyle(
                          fontSize: 20.0.sp,
                          color: Colors.white,fontFamily: LATO,
                          fontWeight: FontWeight.w500)
                    ),
                  ),
                Container(
                  height: 60.0.h,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 76.0.w,
                  ),
                ),
               Container(
                  height: 60.0.h,
                  width: 70.0.w,
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
                                  child: Text(
                                      'Open settings',
                                      style:TextStyle(
                                          color: Colors.white,
                                          fontFamily: MONTSERRAT,
                                          fontWeight: FontWeight.w500
                                      )),
                                  onPressed: () {
                                    AppSettings.openDeviceSettings();
                                  },
                                )
                              ],
                            ));
                      },
                      icon: Image.asset(
                        'assets/images/SETTINGS-WHITE.png',
                        width: 25.0.w,
                      )
                  ),
                ),
            ],
          ),
           Divider(height: 1.0.h, color: Colors.white),
          ],
        )

          );
  }
}

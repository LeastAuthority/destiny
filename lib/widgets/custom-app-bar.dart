import 'package:app_settings/app_settings.dart';
import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
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
                    LOGO,
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
                        if(title != SETTINGS)
                          Navigator.pushNamed(context, SETTINGS_ROUTE);
                      },
                      icon: Image.asset(title == SETTINGS?
                        SETTINGS_ICON_WITH_CIRCLE:SETTINGS_ICON,
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

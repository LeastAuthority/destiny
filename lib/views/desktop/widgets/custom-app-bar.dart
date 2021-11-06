import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  String? path;
  CustomAppBar({String? path, Key? key}):super(key: key){
    this.path = path;
  }

  @override
  final Size preferredSize = Size.fromHeight(140.0.h); // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState(this.path);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? path ;
  _CustomAppBarState(this.path);

  Widget getBorderLine (String screen) {
    if(path == screen)
      return  Container(
          height: 2.0.h,
          width: 30.0.w,
          margin: EdgeInsets.only(top: 4.0.h),
          color: Theme.of(context).colorScheme.secondary
      );
    return  Container(width: 30.0.w,);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        key: Key(CUSTOM_NAV_BAR_CONTAINER),
        child: Container(
          child: Column (
            key: Key(CUSTOM_NAV_BAR_BODY),
            children: [
              Container(
                key: Key(CUSTOM_NAV_BAR_MIDDLE_ITEM),
                height: 60.0.h,
                // width: 70.0.w,
                margin: EdgeInsets.only(bottom: 8.0.h),
                alignment: Alignment.center,
                child: Image.asset(
                  LOGO,
                  width: 76.0.w,
                ),
              ),
            Container (
              margin: EdgeInsets.fromLTRB( 48.0.w, 0.0, 48.0.w, 0.0.h),
              padding: EdgeInsets.fromLTRB(0, 8.0.h, 0, 4.0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                gradient: LinearGradient(
                  stops: [0.0, 1.0],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: <Color>[
                    Theme.of(context).primaryColorLight,
                    Theme.of(context).primaryColor
                  ],
                  tileMode: TileMode.clamp, // repeats the gradient over the canvas
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded (
                      key: Key(BOTTOM_NAV_BAR_LEFT_ITEM),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    SEND_ROUTE,
                                  );
                                },
                                child:  Column(
                                  children: [
                                    Image.asset(
                                      SEND_ICON,
                                      width: 40.0.w,
                                      height: 20.0.h,
                                    ),
                                    Text(
                                        SEND,
                                        style: Theme.of(context).textTheme.headline5
                                    ),
                                    getBorderLine(SEND_ROUTE)
                                  ],
                                )
                            ),
                          ],
                        ),
                      )
                  ),
                  Expanded (
                    // key: Key(BOTTOM_NAV_BAR_RIGHT_ITEM),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    RECEIVE_ROUTE,
                                  );
                                },
                                child:  Column(
                                  children: [
                                    Image.asset(
                                      RECEIVE_ICON,
                                      width: 40.0.w,
                                      height: 20.0.h,
                                    ),
                                    Text(
                                      RECEIVE,
                                      style: Theme.of(context).textTheme.headline5,
                                    ),
                                    getBorderLine(RECEIVE_ROUTE)
                                  ],
                                )
                            ),
                          ],
                        ),
                      )
                  ),
                  Expanded (
                      key: Key(BOTTOM_NAV_BAR_RIGHT_ITEM),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    RECEIVE_ROUTE,
                                  );
                                },
                                child:  Column(
                                  children: [
                                    Image.asset(
                                      SETTINGS_ICON,
                                      width: 40.0.w,
                                      height: 20.0.h,
                                    ),
                                    Text(
                                      SETTINGS,
                                      style: Theme.of(context).textTheme.headline5,
                                    ),
                                    getBorderLine(SETTINGS_ROUTE)
                                  ],
                                )
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),
            )
            ],
          ),
        )
    );
  }
}
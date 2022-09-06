import 'package:destiny/config/theme/colors.dart';
import 'package:destiny/views/desktop/widgets/NavbarTap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:destiny/config/routes/routes.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/constants/asset_path.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String path;
  CustomAppBar({required this.path, Key? key}) : super(key: key);

  @override
  final Size preferredSize = Size.fromHeight(150.0.h);

  @override
  _CustomAppBarState createState() => _CustomAppBarState(this.path);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String path;
  _CustomAppBarState(this.path);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        key: Key(CUSTOM_NAV_BAR_CONTAINER),
        child: Container(
          child: Column(
            key: Key(CUSTOM_NAV_BAR_BODY),
            children: [
              Container(
                key: Key(CUSTOM_NAV_BAR_MIDDLE_ITEM),
                height: 60.0.h,
                margin: EdgeInsets.only(bottom: 8.0.h),
                alignment: Alignment.center,
                child: Image.asset(
                  LOGO,
                  width: 76.0,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(270.0.w, 0.0, 270.0.w, 0.0.h),
                padding: EdgeInsets.fromLTRB(16.0.w, 8.0.h, 16.0.w, 4.0.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  gradient: LinearGradient(
                    stops: [0.0, 0.4],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: <Color>[
                      Theme.of(context).primaryColorLight.withOpacity(0.5),
                      CustomColors.veryDarkPurple.withOpacity(0.5)
                    ],
                    tileMode:
                        TileMode.clamp, // repeats the gradient over the canvas
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NavbarTap(
                      // key: Key(BOTTOM_NAV_BAR_RIGHT_ITEM),
                      route: DESKTOP_SEND_ROUTE,
                      currentRoute: path,
                      title: SEND,
                      icon: SEND_ICON,
                      alignment: CrossAxisAlignment.start,
                    ),
                    NavbarTap(
                      // key: Key(BOTTOM_NAV_BAR_RIGHT_ITEM),
                      route: RECEIVE_ROUTE,
                      title: RECEIVE,
                      currentRoute: path,
                      icon: RECEIVE_ICON,
                      alignment: CrossAxisAlignment.center,
                    ),
                    NavbarTap(
                      // key: Key(BOTTOM_NAV_BAR_RIGHT_ITEM),
                      route: SETTINGS_ROUTE,
                      title: SETTINGS,
                      currentRoute: path,
                      icon: SETTINGS_ICON,
                      alignment: CrossAxisAlignment.end,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

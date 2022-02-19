import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  CustomAppBar({this.title, Key? key}) : super(key: key);

  @override
  final Size preferredSize = Size.fromHeight(85.0.h);

  @override
  _CustomAppBarState createState() => _CustomAppBarState(this.title);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String? title;
  _CustomAppBarState(this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        key: Key(CUSTOM_NAV_BAR_CONTAINER),
        child: Column(
          key: Key(CUSTOM_NAV_BAR_BODY),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 16.0.w),
                Expanded(
                  flex: 3,
                  key: Key(CUSTOM_NAV_BAR_LEFT_ITEM),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 60.0.h,
                    child: Text(
                      '$title',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                Expanded(
                    flex: 6,
                    key: Key(CUSTOM_NAV_BAR_MIDDLE_ITEM),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          SEND_ROUTE,
                        );
                      },
                      child: Container(
                        height: 60.0.h,
                        alignment: Alignment.center,
                        child: Image.asset(
                          LOGO,
                          width: 76.0.w,
                        ),
                      ),
                    )),
                Expanded(
                  flex: 3,
                  key: Key(CUSTOM_NAV_BAR_RIGHT_ITEM),
                  child: GestureDetector(
                      onTap: () {
                        if (title != SETTINGS)
                          Navigator.pushNamed(context, SETTINGS_ROUTE);
                      },
                      child: Container(
                        height: 60.0.h,
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          title == SETTINGS
                              ? SETTINGS_ICON_WITH_CIRCLE
                              : SETTINGS_ICON,
                          width: 25.0.w,
                        ),
                      )),
                ),
                SizedBox(width: 16.0.w),
              ],
            ),
            Divider(height: 1.0.h, color: Colors.white),
          ],
        ));
  }
}

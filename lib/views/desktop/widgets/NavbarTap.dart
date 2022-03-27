import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavbarTap extends StatelessWidget {
  final String route;
  final String currentRoute;
  final String title;
  final String icon;
  final CrossAxisAlignment alignment;
  NavbarTap(
      {Key? key,
      required this.route,
      required this.currentRoute,
      required this.title,
      required this.icon,
      required this.alignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        key: Key(BOTTOM_NAV_BAR_LEFT_ITEM),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: alignment,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      route,
                    );
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        icon,
                        width: 45.0.w,
                        height: 25.0.h,
                      ),
                      Text(title, style: Theme.of(context).textTheme.headline4),
                      route == currentRoute
                          ? Container(
                              height: 2.0.h,
                              width: 50.0.w,
                              margin: EdgeInsets.only(top: 4.0.h),
                              color: Theme.of(context).colorScheme.secondary)
                          : Container(
                              width: 50.0.w,
                              height: 2.0.h,
                              margin: EdgeInsets.only(top: 4.0.h),
                            )
                    ],
                  )),
            ],
          ),
        ));
  }
}

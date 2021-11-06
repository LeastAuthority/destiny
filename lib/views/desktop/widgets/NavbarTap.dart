import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavbarTap extends StatelessWidget {
  String route  = '';
  String currentRoute  = '';
  String title  = '';
  String icon  = '';
  CrossAxisAlignment alignment = CrossAxisAlignment.center;
  NavbarTap({
    Key? key,
    String route = '',
    String currentRoute = '',
    String title = '',
    String icon = '',
    CrossAxisAlignment alignment = CrossAxisAlignment.center
  }):super(key:key) {
    this.route = route;
    this.currentRoute = currentRoute;
    this.title = title;
    this.icon = icon;
    this.alignment = alignment;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded (
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
                  child:  Column(
                    children: [
                      Image.asset(
                        icon,
                        width: 40.0.w,
                        height: 20.0.h,
                      ),
                      Text(
                          title,
                          // style: Theme.of(context).textTheme.headline5
                      ),
                      route == currentRoute?
                        Container(
                          height: 2.0.h,
                          width: 30.0.w,
                          margin: EdgeInsets.only(top: 4.0.h),
                          color: Theme.of(context).colorScheme.secondary
                        ): Container(width: 30.0.w,)
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}

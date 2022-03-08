import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/app_constants.dart';

class BottomBarTap extends StatelessWidget {
  final String iconPath;
  final String route;
  final String path;
  final String label;

  BottomBarTap(
    this.route,
    this.iconPath,
    this.path,
    this.label,
    Key? key,
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Decoration getTapBottomBorder(String screen) {
      if (path == screen)
        return BoxDecoration(
          border: Border(
            bottom:
                BorderSide(width: 6.0, color: Theme.of(context).primaryColor),
          ),
        );
      return BoxDecoration(
        border: Border(
          bottom: BorderSide(
              width: 6.0, color: Theme.of(context).bottomAppBarTheme.color!),
        ),
      );
    }

    return Expanded(
        key: Key(BOTTOM_NAV_BAR_RIGHT_ITEM),
        flex: 1,
        child: Container(
          decoration: getTapBottomBorder(route),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        iconPath,
                        width: 40.0.w,
                        height: 20.0.h,
                      ),
                      Text(
                        label,
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  )),
            ],
          ),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';

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
        key: Key(CUSTOM_NAV_BAR_CONTAINER),
        child: Column (
          key: Key(CUSTOM_NAV_BAR_BODY),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Container(
                  key: Key(CUSTOM_NAV_BAR_LEFT_ITEM),
                  alignment: Alignment.centerLeft,
                  height: 60.0.h,
                  padding: EdgeInsets.only(left:8.0.w),
                  child: Text(
                      '$title',
                      style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                Container(
                  key: Key(CUSTOM_NAV_BAR_MIDDLE_ITEM),
                  height: 60.0.h,
                    alignment: Alignment.center,
                    child: GestureDetector(
                     onTap: () {
                       Navigator.pushNamed(context, SEND_ROUTE);
                     },
                     child: Image.asset(
                      LOGO,
                      width: 76.0.w,
                    ),
                  )
                ),
               Container(
                 key: Key(CUSTOM_NAV_BAR_RIGHT_ITEM),
                 child:
                 PopupMenuButton(
                    onSelected: (result) {
                      Navigator.pushNamed(context, SETTINGS_ROUTE);
                    },
                     color: Theme.of(context).scaffoldBackgroundColor,
                     icon: Image.asset(
                       BURGER_ICON,
                       width: 76.0.w,
                     ),
                     itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                       value:'WhyFarther.harder',
                       child: Text(
                           CUSTOM_NAV_BAR_MENU_FANDQ_ITEM,
                           style: TextStyle(color: Theme.of(context).colorScheme.secondary)
                       ),
                     ),
                      PopupMenuItem(
                       value: 'settings',
                       child: Text(
                           SETTINGS,
                           style: TextStyle(color: Theme.of(context).colorScheme.secondary)
                       )
                     ),
                   ],
                 )
               )
            ],
          ),
           Divider(
               height: 1.0.h,
               color: Theme.of(context).colorScheme.secondary
           ),
          ],
        )
    );
  }
}

import 'package:destiny/views/mobile/widgets/BottomBarTap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:destiny/config/routes/routes.dart';
import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/constants/asset_path.dart';

import '../../../generated/locale_keys.g.dart';

class CustomBottomBar extends StatelessWidget {
  final String path;
  CustomBottomBar({Key? key, required this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 1.0),
        color: Theme.of(context).bottomAppBarTheme.color,
        key: Key(BOTTOM_NAV_BAR_CONTAINER),
        child: Container(
          key: Key(BOTTOM_NAV_BAR_BODY),
          height: 55.0.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BottomBarTap(
                SEND_ROUTE,
                SEND_ICON,
                this.path,
                LocaleKeys.send_title.tr(),
                Key(BOTTOM_NAV_BAR_LEFT_ITEM),
              ),
              BottomBarTap(
                RECEIVE_ROUTE,
                RECEIVE_ICON,
                this.path,
                LocaleKeys.receive_title.tr(),
                Key(BOTTOM_NAV_BAR_RIGHT_ITEM),
              )
            ],
          ),
        ));
  }
}

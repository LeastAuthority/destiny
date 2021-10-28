import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';

class CustomBottomBar extends StatelessWidget {
  String? path;
  CustomBottomBar({Key? key, String? path}):super(key:key){
    this.path = path;
  }
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width * 0.4);
    Decoration getCurrentPath (String screen) {
      if(path == screen)
        return  BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 4.0, color: Color(0xffC24DF8)),
          ),
        );
      else if(path == screen){
        return  BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 4.0, color: Color(0xffC24DF8)),
          ),
        );
      }
      return  BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.0, color: Color(0xff353846)),
        ),
      );
    }
    return Container(
        padding: EdgeInsets.only(bottom: 1.0),
        // color: Theme.of(context).scaffoldBackgroundColor,
        color: Color(0xff363847),
        key: Key(BOTTOM_NAV_BAR_CONTAINER),
        child: Container(
        key: Key(BOTTOM_NAV_BAR_BODY),
        height: 55.0.h,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded (
                key: Key(BOTTOM_NAV_BAR_LEFT_ITEM),
                flex:1,
              child: Container(
                decoration: getCurrentPath(SEND_ROUTE),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      TextButton(
                          onPressed: () {
                            // String? currentRoute = ModalRoute.of(context)!.settings.name;
                            // if(currentRoute  != SEND_ROUTE || currentRoute  != RECEIVE_ROUTE)
                            Navigator.pushReplacementNamed(context, SEND_ROUTE);
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
                                style: Theme.of(context).textTheme.headline4
                              )
                            ],
                          )
                    ),
                  ],
                ),
              )
            ),
            Expanded (
                key: Key(BOTTOM_NAV_BAR_RIGHT_ITEM),
                flex:1,
                child: Container(
                  decoration: getCurrentPath(RECEIVE_ROUTE),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                             TextButton(
                              onPressed: () {
                                // String? currentRoute = ModalRoute.of(context)!.settings.name;
                                // if(currentRoute != SEND_ROUTE || currentRoute  != RECEIVE_ROUTE)
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
                                    style: Theme.of(context).textTheme.headline4,
                                  )
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
    );
  }
}

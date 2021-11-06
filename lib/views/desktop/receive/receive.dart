import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/custom-app-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';


class Receive extends StatefulWidget {
  Receive({Key? key}) : super(key: key);
  @override
  _ReceiveState createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            key:Key(CUSTOM_NAV_BAR),
            path: RECEIVE_ROUTE
        ),
        body: WillPopScope(
        onWillPop: () async => false,
        child:Container(
          width: double.infinity,
          key: Key(SEND_SCREEN_BODY),
          padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
          child: Container (
            height:  double.infinity,
            margin: EdgeInsets.fromLTRB(16.0.w, 0.0, 16.0.w, 4.0.w),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2.0, color: CustomColors.purple),
                  top: BorderSide(width: 2.0, color: CustomColors.purple),
                  left: BorderSide(width: 2.0, color: CustomColors.purple),
                  right: BorderSide(width: 2.0, color: CustomColors.purple),
                ),
              ),
            child: Text('RECEIVE_ROUTE'),
          )
        )
        )
    );
  }
}

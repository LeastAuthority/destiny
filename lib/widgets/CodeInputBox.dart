import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';

class CodeInputBox extends StatelessWidget {
  final Function codeChanged;
  final double width;
  late final TextEditingController controller;
  CodeInputBox(
      {Key? key,
      required this.codeChanged,
      required this.width,
      required final this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: Border(
              top:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
              bottom:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
              left:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
              right: BorderSide(
                  color: Theme.of(context).primaryColor, width: 1.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width - 30.0.w,
            child: TextField(
              controller: controller,
              onChanged: (txt) {
                codeChanged(txt);
              },
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 30.0),
                hintStyle: Theme.of(context).textTheme.bodyText1,
                hintText: ENTER_CODE,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0x000000), width: 0.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0x000000), width: 0.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              codeChanged('');
              controller.text = '';
            },
            child: controller.text.length > 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(X,
                          style: TextStyle(
                              fontSize: 22.0.sp,
                              color: Theme.of(context).colorScheme.secondary)),
                      SizedBox(
                        height: 37.0.h,
                      )
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DTSelectAFile extends StatelessWidget {
  Function handleSelectFile = () {};
  Function handleFileDroped = () {};
  DTSelectAFile(
      {Key? key,
      required Function handleSelectFile,
      required Function handleFileDroped})
      : super(key: key) {
    this.handleSelectFile = handleSelectFile;
    this.handleFileDroped = handleFileDroped;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropTarget(
        onDragDone: (detail) {
          handleFileDroped(detail.urls[0].toString());
        },
        onDragEntered: (detail) {
          // print(detail);
          // setState(() {
          //   // _dragging = true;
          // });
        },
        onDragExited: (detail) {
          // setState(() {
          //   // _dragging = false;
          // });
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Heading(
                title: SEND_FILES_SIMPLE_SECURE_FAST,
                textStyle: Theme.of(context).textTheme.headline1,
              ),
              Column(
                children: [
                  Heading(
                    title: DROP_A_FILE,
                    textStyle: Theme.of(context).textTheme.headline5,
                  ),
                  Heading(
                    title: OR,
                    textStyle: Theme.of(context).textTheme.headline4,
                    marginTop: 26.0.h,
                  ),
                ],
              ),
              FlatButton(
                onPressed: () {
                  handleSelectFile();
                },
                child: Image.asset(
                  PLUS_ICON,
                  width: 250.0.w,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

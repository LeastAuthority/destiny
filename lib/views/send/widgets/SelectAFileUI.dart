import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
// import 'package:dart_wormhole_william/client.dart';
import '../../../widgets/buttons/ButtonWithIcon.dart';

class SelectAFileUI extends StatelessWidget {
  final int fileSize;
  final String fileName;
  final String _code;
  final Function handleSelectFile;
  SelectAFileUI(this.fileSize, this.fileName,  this._code, this.handleSelectFile);
  @override
  Widget build(BuildContext context) {
    return Column(
        key: Key(SEND_SCREEN_CONTENT),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Heading(
            title: SEND_AND_RECEIVE_FILES_SECURLY_AND_FAST,
            textAlign: TextAlign.left,
            marginTop: 0,
            textStyle: Theme.of(context).textTheme.bodyText1,
            key: Key(SEND_SCREEN_HEADING),
          ),
          ButtonWithIcon(
            label: SELECT_A_FILE,
            handleSelectFile: handleSelectFile,
            icon:Image.asset(
            PHONE_ICON,
            width: 30.0.w,
            ),
            height:60.0.h,
            width: 200.0.w,
            isVertical: false,
            key:Key(SEND_SCREEN_SELECT_A_FILE_BUTTON)
          ),
          SizedBox(
            key:Key(SEND_SCREEN_BOTTOM_SPACE_PLACEHOLDER),
            height: 100.h,
          ),
        ]
    );
  }
}

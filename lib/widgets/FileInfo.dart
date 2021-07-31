import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/widgets/DescriptionContainer.dart';

class FileInfo extends StatelessWidget {
  final int fileSize;
  final String fileName;

  FileInfo(this.fileSize, this.fileName);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 32.0.h),
          child: Align(
            alignment: Alignment.center,
            child: Text('${fileName}',
              style:TextStyle(color: Colors.white, fontSize: 17.sp),
            ),
          ),
        ),
        DescriptionContainer('(${fileSize} kb)', TextAlign.center,0, 12.sp, Key('File_Info_Description'),),
      ],
    );
  }
}

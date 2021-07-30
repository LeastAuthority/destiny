import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/widgets/DescriptionContainer.dart';

import 'Button.dart';
import 'FileInfo.dart';

class SentSuccessfully extends StatelessWidget {
  final int fileSize;
  final String fileName;

  SentSuccessfully(this.fileSize, this.fileName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FileInfo(fileSize, fileName),
        DescriptionContainer(
            'File sent',
            TextAlign.left,
            16.0.h,
            25.sp
        ),
        Image.asset(
          'assets/images/file-sent-white.png',
          width: 100.0.w,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/widgets/Heading.dart';

import '../../../widgets/buttons/Button.dart';
import '../../../widgets/FileInfo.dart';

class SentSuccessfully extends StatelessWidget {
  final int fileSize;
  final String fileName;

  SentSuccessfully(this.fileSize, this.fileName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FileInfo(fileSize, fileName),
        Heading(
          title: 'File sent',
          textAlign: TextAlign.left,
          marginTop:16.0.h,
          fontSize:25.sp,
          key: Key('FILE_SENT'),
        ),
        Image.asset(
          'assets/images/file-sent-white.png',
          width: 100.0.w,
        )
      ],
    );
  }
}

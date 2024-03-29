import 'package:destiny/views/shared/util.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileInfo extends StatelessWidget {
  final int fileSize;
  final String fileName;

  FileInfo(this.fileSize, this.fileName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 32.0.h),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '$fileName',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        Heading(
          title: '(${fileSize.readableSize})',
          textStyle: Theme.of(context).textTheme.subtitle1,
          key: Key('File_Info_Description'),
        ),
      ],
    );
  }
}

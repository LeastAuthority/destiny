import 'package:dart_wormhole_gui/views/mobile/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FileInfo extends StatelessWidget {
  final int? fileSize;
  final String? fileName;

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
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
        Heading(
          title: '(${fileSize} kb)',
          textAlign: TextAlign.center,
          marginTop:0,
          textStyle: Theme.of(context).textTheme.bodyText2,
          key: Key('File_Info_Description'),
        ),
      ],
    );
  }
}

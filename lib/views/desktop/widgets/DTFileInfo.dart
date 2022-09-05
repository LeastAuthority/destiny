import 'package:destiny/views/shared/util.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:flutter/material.dart';

class DTFileInfo extends StatelessWidget {
  final int? fileSize;
  final String? fileName;

  DTFileInfo(this.fileSize, this.fileName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 32.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '$fileName',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        Heading(
          title: '(${fileSize?.readableSize})',
          textAlign: TextAlign.center,
          marginTop: 0,
          textStyle: Theme.of(context).textTheme.subtitle1,
          key: Key('File_Info_Description'),
        ),
      ],
    );
  }
}

import 'package:dart_wormhole_william/client/file.dart';
import 'package:destiny/views/desktop/send/widgets/DTSelectAFile.dart';
import 'package:destiny/views/shared/util.dart';
import 'package:dart_wormhole_william/client/file.dart' as f;
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import 'DTDropAFile.dart';

class DTSelectOrDropAFile extends StatefulWidget {
  final Future<void> Function() onFileSelected;
  final Future<void> Function(f.File) onFileDropped;
  bool dragEntered = false;
  DTSelectOrDropAFile(
      {Key? key, required this.onFileSelected, required this.onFileDropped})
      : super(key: key);

  @override
  State<DTSelectOrDropAFile> createState() => _DTSelectOrDropAFile();
}

class _DTSelectOrDropAFile extends State<DTSelectOrDropAFile> {
  @override
  Widget build(BuildContext context) {
    bool flag = false;
    return Container(
      color: widget.dragEntered
          ? Color(0xff3A2655)
          : Theme.of(context).dialogBackgroundColor,
      child: DropTarget(
        onDragDone: (detail) async {
          if (flag == true) return;
          try {
            File file = detail.files.first.readOnlyFile();
            await widget.onFileDropped(file);
            flag = true;
          } catch (e) {
            bool isFile = detail.files.first.path.split('.').length == 0;
            flag = true;
            if (isFile) return;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(DIRECTORIES_ARE_NOT_ALLOWED),
            ));
          }
          flag = true;
        },
        onDragEntered: (detail) async {
          flag = false;
          this.setState(() {
            widget.dragEntered = true;
          });
        },
        onDragExited: (detail) async {
          this.setState(() {
            widget.dragEntered = false;
          });
        },
        child: widget.dragEntered
            ? DTDropAFile()
            : DTSelectAFile(widget.onFileSelected),
      ),
    );
  }
}

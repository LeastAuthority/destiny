import 'package:dart_wormhole_gui/views/desktop/send/widgets/DTSelectAFile.dart';
import 'package:dart_wormhole_gui/views/shared/util.dart';
import 'package:dart_wormhole_william/client/file.dart' as f;
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';

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
    return Container(
      color: widget.dragEntered
          ? Color(0xff3A2655)
          : Theme.of(context).dialogBackgroundColor,
      child: DropTarget(
        onDragDone: (detail) async {
          await widget.onFileDropped(detail.files.first.readOnlyFile());
        },
        onDragEntered: (detail) async {
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

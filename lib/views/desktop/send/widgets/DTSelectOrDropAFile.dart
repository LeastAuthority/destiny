import 'dart:io' as dartIO;

import 'package:dart_wormhole_william/client/file.dart';
import 'package:dart_wormhole_william/client/file.dart' as f;
import 'package:desktop_drop/desktop_drop.dart';
import 'package:destiny/views/desktop/send/widgets/DTSelectAFile.dart';
import 'package:destiny/views/shared/util.dart';
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
  DateTime? lastDrop;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.dragEntered
          ? Color(0xff3A2655)
          : Theme.of(context).dialogBackgroundColor,
      child: DropTarget(
        onDragDone: (detail) async {
          // TODO this is a workaround for the desktop_drop plugin calling onDragDone
          // multiple times when a drop happens
          if (lastDrop == null
              ? true
              : lastDrop!
                  .isBefore(DateTime.now().subtract(Duration(seconds: 1)))) {
            lastDrop = DateTime.now();

            final fileStat = await dartIO.File(detail.files.first.path).stat();
            if (fileStat.type != dartIO.FileSystemEntityType.file) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(DIRECTORIES_ARE_NOT_ALLOWED),
              ));

              return Future.error(DIRECTORIES_ARE_NOT_ALLOWED);
            } else {
              File file = detail.files.first.readOnlyFile();
              await widget.onFileDropped(file);
            }
          } else {
            return Future.error("Ignoring superfluous drop");
          }
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

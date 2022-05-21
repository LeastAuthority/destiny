import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:dart_wormhole_gui/views/shared/util.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_william/client/file.dart' as f;
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DTSelectAFile extends StatelessWidget {
  final Future<void> Function() onFileSelected;
  final Future<void> Function(f.File) onFileDropped;

  DTSelectAFile(
      {Key? key, required this.onFileSelected, required this.onFileDropped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).dialogBackgroundColor,
      child: DropTarget(
        onDragDone: (detail) async {
          await onFileDropped(detail.files.first.readOnlyFile());
        },
        child: Container(
          padding: EdgeInsets.only(top: 80.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Heading(
                title: SEND_FILES_SIMPLE_SECURE_FAST,
                textStyle: Theme.of(context).textTheme.headline1,
              ),
              Column(
                children: [
                  Heading(
                    title: DROP_A_FILE,
                    textStyle: Theme.of(context).textTheme.headline5,
                  ),
                  Heading(
                    title: OR,
                    textStyle: Theme.of(context).textTheme.headline5,
                    marginTop: 26.0,
                  ),
                ],
              ),
              MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      await onFileSelected();
                    },
                    child: Container(
                      height: 200.0,
                      width: 250.0,
                      child: Image.asset(
                        PLUS_ICON,
                        width: 250.0,
                      ),
                    ),
                  )),
              SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

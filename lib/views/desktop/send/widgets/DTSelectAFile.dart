import 'package:destiny/constants/app_constants.dart';
import 'package:destiny/constants/asset_path.dart';
import 'package:destiny/generated/locale_keys.g.dart';
import 'package:destiny/views/widgets/Heading.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DTSelectAFile extends StatelessWidget {
  final Function onFileSelected;
  DTSelectAFile(this.onFileSelected);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 80.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Heading(
            title: LocaleKeys.send_topic.tr(),
            textStyle: Theme.of(context).textTheme.headline1,
          ),
          Column(
            children: [
              Heading(
                title: LocaleKeys.send_drop_file.tr(),
                textStyle: Theme.of(context).textTheme.headline5,
              ),
              Heading(
                title: LocaleKeys.generic_or.tr(),
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
    );
  }
}

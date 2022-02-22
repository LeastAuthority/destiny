import 'package:dart_wormhole_gui/constants/asset_path.dart';
import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? path;
  final TextAlign textAlign;
  final double marginTop;
  final TextStyle? textStyle;
  Heading(
      {Key? key,
      this.title,
      this.subTitle,
      this.path = '',
      this.textAlign = TextAlign.center,
      this.marginTop = 0,
      this.textStyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (subTitle == null)
      return Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: marginTop),
          child: new RichText(
            textAlign: textAlign,
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: textStyle,
              children: <TextSpan>[
                new TextSpan(text: title),
                new TextSpan(
                    text: ' $path',
                    style: new TextStyle(fontFamily: MONTSERRAT_MEDIUM)),
              ],
            ),
          ));

    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: marginTop),
          child: Text('$title', textAlign: textAlign, style: textStyle),
        ),
      ],
    );
  }
}

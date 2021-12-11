import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  String? title;
  String? subTitle;
  String? path;
  TextAlign textAlign = TextAlign.center;
  double marginTop = 0.0;
  TextStyle? textStyle;
  Heading(
      {Key? key,
      String? title,
      String? subTitle,
      String? path = '',
      TextAlign textAlign = TextAlign.center,
      double marginTop = 0,
      TextStyle? textStyle})
      : super(key: key) {
    this.title = title;
    this.subTitle = subTitle;
    this.path = path;
    this.textAlign = textAlign;
    this.marginTop = marginTop;
    this.textStyle = textStyle;
  }
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
                    text: path,
                    style: new TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ));

    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: marginTop),
          // ignore: unnecessary_brace_in_string_interps
          child: Text('${title}', textAlign: textAlign, style: textStyle),
        ),
      ],
    );
  }
}

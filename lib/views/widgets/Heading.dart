import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? path;
  final TextAlign textAlign;
  final double marginTop;
  final TextStyle? textStyle;
  final bool? isVisible;
  Heading(
      {Key? key,
      this.title,
      this.subTitle,
      this.path = '',
      this.textAlign = TextAlign.center,
      this.marginTop = 0,
      this.textStyle,
      this.isVisible = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isVisible == false) return Container();
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
                    style: Theme.of(context).textTheme.subtitle1)
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

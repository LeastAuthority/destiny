import 'package:flutter/material.dart';
import 'package:destiny/constants/app_constants.dart';

class CodeInputBox extends StatelessWidget {
  final Function codeChanged;
  final double width;
  final TextStyle? style;
  late final TextEditingController controller;
  final void Function(String) onEnterPressed;

  CodeInputBox(
      {Key? key,
      required this.style,
      required this.codeChanged,
      required this.width,
      required this.controller,
      required this.onEnterPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border:
              Border.all(color: Theme.of(context).primaryColor, width: 1.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width - 30.0,
            child: TextField(
              controller: controller,
              onSubmitted: onEnterPressed,
              onChanged: (txt) {
                codeChanged(txt);
              },
              style: style,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 30.0),
                hintStyle: style,
                hintText: ENTER_CODE,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0x000000), width: 0.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0x000000), width: 0.0),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              codeChanged('');
              controller.text = '';
            },
            child: controller.text.length > 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(X,
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Theme.of(context).colorScheme.secondary)),
                      SizedBox(
                        height: 37.0,
                      )
                    ],
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}

import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import '../constants/asset_path.dart';
class ExpandableTextBox extends StatelessWidget {
  final String? error;
  final String? errorMessage;
  final bool? showBorders;
  final double? height;
  final double? fontSize;

  ExpandableTextBox({
    Key? key,
    this.error = '',
    this.errorMessage = '',
    this.showBorders = false,
    this.height,
    this.fontSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpandChild(
        showBorders: showBorders,
        expandedBGColor: Color(0xff1A1C2E),
        arrowColor: Theme.of(context).primaryColor,
        arrowSize: 40.0,
        child: Container(
            padding: EdgeInsets.all(16.0),
            child: Container(
                height: height,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Heading(
                        title: errorMessage ?? errorMessage.toString(),
                        textStyle: TextStyle(
                          color: Theme.of(context).textTheme.headline1?.color,
                          fontSize: fontSize,
                          fontFamily: COURIER,
                        ),
                        textAlign: TextAlign.left),
                  ],
                )))));
  }
}

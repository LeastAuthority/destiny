import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double value;
  CustomLinearProgressIndicator({Key? key, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor:
          Theme.of(context).progressIndicatorTheme.linearTrackColor,
      color: Theme.of(context).progressIndicatorTheme.color,
      value: value,
    );
  }
}

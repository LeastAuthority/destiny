import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:flutter/material.dart';

class DTButtonWithBackground extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final double width;
  final Widget? icon;
  final disabled;

  DTButtonWithBackground({
    required this.title,
    required this.onPressed,
    required this.width,
    this.icon,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(
            width: 1.0,
            color: disabled
                ? Theme.of(context).primaryColorDark
                : CustomColors.purple),
      ),
      constraints: BoxConstraints(maxWidth: width, minWidth: 100.0),
      height: 30.0,
      child: TextButton(
        onPressed: disabled ? null : onPressed,
        style: TextButton.styleFrom(
            backgroundColor: disabled
                ? Theme.of(context).primaryColorDark
                : Theme.of(context).primaryColor),
        child: Text('$title', style: Theme.of(context).textTheme.subtitle2),
      ),
    );
  }
}

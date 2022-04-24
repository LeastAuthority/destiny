import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:flutter/material.dart';

class DTButton extends StatefulWidget {
  final String title;
  final Function onPressed;
  DTButton(this.title, this.onPressed);

  @override
  _CustomAppBarState createState() => _CustomAppBarState(title, onPressed);
}

class _CustomAppBarState extends State<DTButton> {
  final String title;
  Function onPressed;
  Widget? icon;
  _CustomAppBarState(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border.all(width: 1.0, color: CustomColors.purple),
      ),
      width: 100.0,
      height: 30.0,
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor),
        child: Text('$title', style: Theme.of(context).textTheme.headline5),
      ),
    );
  }
}

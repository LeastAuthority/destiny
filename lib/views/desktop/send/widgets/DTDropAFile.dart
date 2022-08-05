import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:flutter/material.dart';

class DTDropAFile extends StatelessWidget {
  DTDropAFile();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Heading(
          title: DROP_HERE,
          textAlign: TextAlign.center,
          textStyle: TextStyle(
            fontSize: 40.0,
            fontFamily: Theme.of(context).textTheme.headline1?.fontFamily,
            color: Theme.of(context).textTheme.headline1?.color,
          ),
          // key: Key('Timing_Progress'),
        ),
      ],
    );
  }
}

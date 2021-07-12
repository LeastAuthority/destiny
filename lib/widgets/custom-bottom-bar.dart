import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      clipBehavior: Clip.none,
      alignment:  FractionalOffset(.5, 1.0),
      children: [
        Container(
          height: 40.0,
          color: Colors.red,
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(top:32),
                  child: Icon(Icons.school),
                ),
                FloatingActionButton(
                  // notchMargin: 24.0,
                  onPressed: () => print('hello world'),
                  child:  Icon(Icons.home),
                ),
                Container(
                  margin: EdgeInsets.only(top:32),
                  child: Icon(Icons.send),
                )
              ],
            )
        ),
      ],
    );
  }
}

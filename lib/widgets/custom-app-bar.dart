import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child:  Icon(
                Icons.add_to_home_screen
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child:  Text('Home', style: TextStyle(fontSize: 20.0),),
          ),
          Divider(height: 10.0, color: Colors.black),
        ],
      ),
    );
  }
}

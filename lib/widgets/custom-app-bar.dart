import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo.png',
              width: 76.0,
              // fit:BoxFit.fitHeight,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child:  Text('$title', style: TextStyle(fontSize: 20.0, color: Colors.white),),
          ),
          Divider(height: 10.0, color: Colors.white),
        ],
      ),
    );
  }
}

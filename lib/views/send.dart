import 'package:flutter/material.dart';


class Send extends StatefulWidget {
  @override
  SendState createState() => new SendState();
}

class SendState extends State<Send> {

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Center(
        child: new Text('Send...'),
      ),
    );
  }
}
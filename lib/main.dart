import 'package:flutter/material.dart';

// TODO: cleanup exports?
import 'views/send_default.dart';
import 'views/receive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
//      home: SendDefault(),
      initialRoute: '/s',
      routes: {
        '/s': (BuildContext context) => SendDefault(),
        '/r': (BuildContext context) => Receive(),
      },
    );
  }
}


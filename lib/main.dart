import 'package:flutter/material.dart';
import 'package:dart_wormhole_william/client.dart';

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
      home: SendDefault(),
    );
  }
}

class SendDefault extends StatefulWidget {
  SendDefault({Key? key}) : super(key: key);

//  final String title;

  @override
  _SendDefaultState createState() => _SendDefaultState();
}

class _SendDefaultState extends State<SendDefault> {
  String _msg = '';
  String _code = '';
  TextEditingController _codeTxtCtrl = TextEditingController();

  Client client = Client();

  void _msgChanged(String msg) {
    setState(() {
      _msg = msg;
    });
  }

  void _codeChanged(String code) {
    setState(() {
      _code = code;
    });
  }

  void _send() {
    String code = client.sendText(_msg);
    _codeTxtCtrl.text = code;
    setState() {
      _code = code;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
//        title: Text(widget.title),
        title: Text('Send Text'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 250),
//        margin: EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: _msgChanged,
            ),
            Text(
              '$_code',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextField(
              controller: _codeTxtCtrl,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _send,
        tooltip: 'Send',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

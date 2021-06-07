import 'package:flutter/material.dart';
import 'package:dart_wormhole_william/client.dart';

class Receive extends StatefulWidget {
  Receive({Key? key}) : super(key: key);

//  final String title;

  @override
  _ReceiveState createState() => _ReceiveState();
}

class _ReceiveState extends State<Receive> {
  String _msg = '';
  String _code = '';
  TextEditingController _msgTxtCtrl = TextEditingController();

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

  void _receive() {
    String msg = client.recvText(_code);
    _msgTxtCtrl.text = msg;
    setState(() {
      _msg = msg;
    });
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
        title: Text('Receive Text'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 250),
//        margin: EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/s'),
                child: Text('Go to Send')),
            TextField(
              onChanged: _codeChanged,
            ),
            Text(
              '$_msg',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextField(
              controller: _msgTxtCtrl,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _receive,
        tooltip: 'Receive',
        child: Icon(Icons.move_to_inbox),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

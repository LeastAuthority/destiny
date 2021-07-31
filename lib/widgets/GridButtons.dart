import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/widgets/DescriptionContainer.dart';

class GridButtons extends StatelessWidget {
  final Function handleSendClicked;
  final Function handleReceiveClicked;
  final Function handleSettingsClicked;

  GridButtons(this.handleSendClicked, this.handleReceiveClicked, this.handleSettingsClicked);

  @override
  Widget build(BuildContext context) {
    return   Column(
      key:Key('HOME_BODY'),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              // width: 100.0.w,
              // height: 150.0.w,
              child:  FlatButton(
                padding: EdgeInsets.fromLTRB(6.0, 18.0, 6.0, 14.0),
                onPressed: () => Navigator.pushNamed(context, '/receive'),
                color: Color(0xff353846),
                child: Column( // Replace with a Row for horizontal icon + text
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/receive.png',
                      width: 90.0.w,
                    ),
                    Text("Receive", style:TextStyle(color: Colors.white, fontSize: 16))
                  ],
                ),
              ),
            ),
            Container(
              // width: 100.0.w,
              // height: 150.0.w,
              margin: const EdgeInsets.all(8.0),
              child:  FlatButton(
                padding: EdgeInsets.fromLTRB(6.0, 18.0, 6.0, 14.0),
                onPressed: () => Navigator.pushNamed(context, '/send'),
                color: Color(0xff353846),
                child: Column( // Replace with a Row for horizontal icon + text
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/send.png',
                      width: 90.0.w,
                    ),
                    Text("Send", style:TextStyle(color: Colors.white, fontSize: 16))
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          width: 220.0.w,
          height: 50.0.w,
          margin: const EdgeInsets.fromLTRB(0,8.0,0,0),
          child:  FlatButton(
            // padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 14.0),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            color: Color(0xff353846),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/send.png',
                  width: 30.0.w,
                ),
                Text("Settings", style:TextStyle(color: Colors.white, fontSize: 16))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

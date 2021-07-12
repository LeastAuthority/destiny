import 'package:flutter/material.dart';
import 'widgets/custom-app-bar.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Home(),
  },
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final keyCounter = GlobalKey<_HomeState>();
  selecteFile () async
  {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    print(result);
    print("Paaaat");
    if(result != null)
      print(result.files.single.path!);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold (
      body: Column(
        children: [
          CustomAppBar(),
          FlatButton(onPressed: (){
            selecteFile();
          }, child: Text('Click')),
          Container(
            //Container to control width of progress bar
            width: 100.0,
            child:  LinearProgressIndicator(
              value: 0.2,
              semanticsLabel: 'Linear progress indicator',
              backgroundColor: Colors.purple,
              color: Colors.red,
            ),
          )
        ],
      ),
      bottomNavigationBar:  Stack(
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
      ),
    );
  }
}


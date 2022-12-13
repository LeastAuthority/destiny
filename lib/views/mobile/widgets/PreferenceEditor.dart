import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'buttons/Button.dart';

class PopupEditText extends StatefulWidget {
  final Preference<String> preference;

  final String title;
  final double marginTop;

  PopupEditText(this.preference, {this.marginTop = 0.0, this.title = ""});

  @override
  State<StatefulWidget> createState() => _PopupEditTextState(this.preference,
      marginTop: this.marginTop, title: this.title);
}

class _PopupEditTextState extends State<PopupEditText> {
  final Preference<String> preference;
  late String value;

  final title;
  final double marginTop;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  _PopupEditTextState(this.preference,
      {required this.marginTop, required this.title})
      : this.value = preference.getValue();

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            var theme = Theme.of(context);
            return AlertDialog(
              backgroundColor: theme.scaffoldBackgroundColor,
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return (value != null && value.isNotEmpty)
                              ? null
                              : "Enter any text";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter Text"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            var defaultValue = preference.defaultValue;
                            update(defaultValue);
                            _textEditingController.text = defaultValue;
                          },
                          child: Text("Set: " + preference.defaultValue))
                    ],
                  )),
              title: Text(title),
              actions: <Widget>[
                Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(color: theme.primaryColor),
                    child: InkWell(
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text('OK', style: theme.textTheme.bodyText2)),
                      onTap: () {
                        var currentState = _formKey.currentState;
                        if (currentState != null && currentState.validate()) {
                          update(_textEditingController.value.text);
                          Navigator.of(context).pop();
                        }
                      },
                    )),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    var dialogBackgroundColor = Theme.of(context).dialogBackgroundColor;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: this.marginTop),
      child: Row(
        children: [
          Text(this.value),
          Spacer(flex: 1),
          Button(
            width: 50.0,
            height: 22.0,
            topMargin: 2.0,
            title: "edit",
            handleClicked: () async {
              _textEditingController.text = this.preference.getValue();
              await showInformationDialog(context);
            },
            disabled: false,
          ),
        ],
      ),
    );
  }

  void update(String newValue) {
    this.preference.setValue(newValue);
    setState(() {
      this.value = newValue;
    });
  }
}

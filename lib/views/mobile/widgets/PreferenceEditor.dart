import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'buttons/Button.dart';

List<String> singleDefault(String defaultValue) {
  return [defaultValue];
}

class PopupEditText extends StatefulWidget {
  final Preference<String> preference;
  final List<String> Function(String) expandDefaults;

  final String title;
  final double marginTop;

  PopupEditText(this.preference,
      {this.marginTop = 0.0,
      this.title = "",
      this.expandDefaults = singleDefault});

  @override
  State<StatefulWidget> createState() => _PopupEditTextState(this.preference,
      expandDefaults: this.expandDefaults,
      marginTop: this.marginTop,
      title: this.title);
}

class _PopupEditTextState extends State<PopupEditText> {
  final Preference<String> preference;
  late String value;
  late List<String> defaultValues;

  final title;
  final double marginTop;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  _PopupEditTextState(this.preference,
      {required this.marginTop,
      required this.title,
      required List<String> Function(String) expandDefaults})
      : this.value = preference.getValue(),
        this.defaultValues = expandDefaults(preference.defaultValue);

  Future<void> showInformationDialog(BuildContext context) async {
    final List<Widget> defaultButtons = defaultValues
        .map((value) => ElevatedButton(
            onPressed: () {
              update(value);
              _textEditingController.text = value;
            },
            child: Text(value)))
        .toList();

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
                          Text("Value:"),
                          TextFormField(
                            controller: _textEditingController,
                            autofocus: true,
                            validator: (value) {
                              return (value != null && value.isNotEmpty)
                                  ? null
                                  : "Enter any text";
                            },
                            decoration:
                                InputDecoration(hintText: "Please Enter Text"),
                          ),
                          SizedBox(height: 10.0),
                          Text("Default value(s):"),
                        ] +
                        defaultButtons,
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

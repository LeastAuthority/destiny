import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:tuple/tuple.dart';

import '../constants/app_constants.dart';
import '../constants/asset_path.dart';
import '../views/mobile/widgets/buttons/Button.dart';
import '../views/widgets/Heading.dart';

List<String> singleDefault(String defaultValue) {
  return [defaultValue];
}

String? defaultValidator(String? value) {
  return (value != null && value.isNotEmpty) ? null : "Enter any text";
}

class EditableStringPrefs extends StatefulWidget {
  final Preference<String> preference;
  final List<String> Function(String) expandDefaults;
  final String? Function(String?) validator;

  final String title;
  final double marginTop;
  final double editButtonWidth;

  EditableStringPrefs(
    this.preference, {
    this.marginTop = 0.0,
    this.title = "",
    this.editButtonWidth = 50.0,
    this.expandDefaults = singleDefault,
    this.validator = defaultValidator,
  });

  @override
  State<StatefulWidget> createState() =>
      _EditableStringPrefsState(this.preference,
          expandDefaults: this.expandDefaults,
          validator: this.validator,
          marginTop: this.marginTop,
          editButtonWidth: this.editButtonWidth,
          title: this.title);
}

class _EditableStringPrefsState extends State<EditableStringPrefs> {
  final Preference<String> preference;
  late String value;
  late List<String> defaultValues;
  final String? Function(String?) validator;

  final title;
  final double marginTop;
  final double editButtonWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  _EditableStringPrefsState(
    this.preference, {
    required this.marginTop,
    required this.editButtonWidth,
    required this.title,
    required List<String> Function(String) expandDefaults,
    required this.validator,
  })  : this.value = preference.getValue(),
        this.defaultValues = expandDefaults(preference.defaultValue);

  Future<void> showInformationDialog(BuildContext context) async {
    var theme = Theme.of(context);
    var smallTextStyle = theme.textTheme.bodyText2?.copyWith(fontSize: 11.0);

    final List<Widget> defaultButtons = indexed(defaultValues).expand((value) {
      return [
        SizedBox(height: 5.0),
        ElevatedButton(
            onPressed: () {
              _textEditingController.text = value.item2;
            },
            key: Key("default${value.item1}"),
            child: Text(value.item2, style: smallTextStyle))
      ];
    }).toList();

    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              key: Key("dialog"),
              backgroundColor: theme.scaffoldBackgroundColor,
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                          TextFormField(
                            key: Key("formField"),
                            controller: _textEditingController,
                            style: theme.textTheme.bodyText2,
                            autofocus: true,
                            validator: this.validator,
                            decoration: InputDecoration(
                              hintText: "Please Enter Text",
                            ),
                          ),
                          SizedBox(height: 24.0),
                          Text(
                            "Choose default:",
                            style: smallTextStyle,
                            key: Key("defaultTitle"),
                          ),
                        ] +
                        defaultButtons,
                  )),
              title: Text(
                EDIT + " " + title,
                style: theme.textTheme.headline3,
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(CANCEL, style: theme.textTheme.bodyText2),
                  key: Key("cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    var currentState = _formKey.currentState;
                    if (currentState != null && currentState.validate()) {
                      update(_textEditingController.value.text);
                      Navigator.of(context).pop();
                    }
                  },
                  style: theme.elevatedButtonTheme.style?.copyWith(
                      backgroundColor:
                          MaterialStateProperty.all(theme.primaryColor)),
                  child: Text(OK, style: theme.textTheme.bodyText2),
                  key: Key("ok"),
                ),
              ],
            );
          });
        });
  }

  Iterable<Tuple2<int, T>> indexed<T>(List<T> values) {
    return values
        .asMap()
        .map((index, value) => MapEntry(index, Tuple2<int, T>(index, value)))
        .values;
  }

  @override
  Widget build(BuildContext context) {
    final headingStyle =
        Theme.of(context).textTheme.headline6?.copyWith(fontFamily: MONTSERRAT);

    return Container(
        margin: EdgeInsets.only(top: this.marginTop),
        child: Column(
          children: [
            Heading(
              key: Key("entryTitle"),
              title: this.title,
              textAlign: TextAlign.left,
              marginTop: 10.0.h,
              textStyle: headingStyle,
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    this.value,
                    key: Key("entryValue"),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                Button(
                  key: Key("entryEditButton"),
                  width: this.editButtonWidth,
                  height: 24.0,
                  topMargin: 2.0,
                  title: EDIT,
                  handleClicked: () async {
                    _textEditingController.text = this.preference.getValue();
                    await showInformationDialog(context);
                  },
                  disabled: false,
                ),
              ],
            ),
          ],
        ));
  }

  void update(String newValue) {
    newValue = newValue.trim();
    this.preference.setValue(newValue);
    setState(() {
      this.value = newValue;
    });
  }
}

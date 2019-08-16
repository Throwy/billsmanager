import 'package:billsmanager/store/AppState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ThemeSettingsPage extends StatefulWidget {
  ThemeSettingsState createState() => new ThemeSettingsState();
}

class ThemeSettingsState extends State<ThemeSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
      ),
      body: ListView(
        children: <Widget>[
          ScopedModelDescendant<AppState>(
            builder: (context, child, model) {
              return RadioListTile(
                title: Text("Dark"),
                value: Brightness.dark,
                groupValue: model.brightness,
                onChanged: (value) {
                  model.changeBrightness(value);
                },
              );
            },
          ),
          ScopedModelDescendant<AppState>(
            builder: (context, child, model) {
              return RadioListTile(
                title: Text("Light"),
                value: Brightness.light,
                groupValue: model.brightness,
                onChanged: (value) {
                  model.changeBrightness(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

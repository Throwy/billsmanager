import 'package:billsmanager/store/AppState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ThemeSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
      ),
      body: ScopedModelDescendant<AppState>(
        builder: (context, child, model) {
          return ListView(
            children: <Widget>[
              RadioListTile(
                title: Text("Dark"),
                value: Brightness.dark,
                groupValue: model.brightness,
                onChanged: (value) {
                  model.themeState.changeBrightness(value);
                },
              ),
              RadioListTile(
                title: Text("Light"),
                value: Brightness.light,
                groupValue: model.brightness,
                onChanged: (value) {
                  model.themeState.changeBrightness(value);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

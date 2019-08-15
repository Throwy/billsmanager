import 'package:billsmanager/helpers/AppBuilder.dart';
import 'package:billsmanager/store/AppState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ThemeSettingsPage extends StatefulWidget {
  ThemeSettingsPage({Key key, @required this.title, @required this.brightness}) : super(key: key);
  final String title;
  final Brightness brightness;

  ThemeSettingsState createState() => new ThemeSettingsState();
}

class ThemeSettingsState extends State<ThemeSettingsPage> {
  Brightness _brightness;

  @override
  void initState() {
    super.initState();
    _brightness = widget.brightness;
  }

  void changeTheme(AppState model, Brightness brightness) {
    setState(() {
      // set the form control to selected brightness
      _brightness = brightness;
      // update the state of the app
      model.changeBrightness(brightness);
      // rebuild the widget tree to render app in selected brightness
      AppBuilder.of(context).rebuild();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ScopedModelDescendant<AppState>(
            builder: (context, child, model) {
              return RadioListTile(
                title: Text("Light"),
                value: Brightness.light,
                groupValue: _brightness,
                onChanged: (value) {
                  changeTheme(model, value);
                },
              );
            },
          ),
          ScopedModelDescendant<AppState>(
            builder: (context, child, model) {
              return RadioListTile(
                title: Text("Dark"),
                value: Brightness.dark,
                groupValue: _brightness,
                onChanged: (value) {
                  changeTheme(model, value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

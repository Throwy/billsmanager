import 'package:billsmanager/helpers/AppBuilder.dart';
import 'package:flutter/material.dart';

class ThemeSettingsPage extends StatefulWidget {
  ThemeSettingsPage({Key key, @required this.title}) : super(key: key);
  final String title;

  ThemeSettingsState createState() => new ThemeSettingsState();
}

class ThemeSettingsState extends State<ThemeSettingsPage> {
  Brightness _brightness;

  @override
  void initState() {
    super.initState();
    _brightness = Brightness.light;
  }

  void changeTheme(Brightness brightness) {
    setState(() {
      _brightness = brightness;
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
          RadioListTile(
            title: Text("Light"),
            value: Brightness.light,
            groupValue: _brightness,
            onChanged: (value) {
              changeTheme(value);
            },
          ),
          RadioListTile(
            title: Text("Dark"),
            value: Brightness.dark,
            groupValue: _brightness,
            onChanged: (value) {
              changeTheme(value);
            },
          ),
        ],
      ),
    );
  }
}

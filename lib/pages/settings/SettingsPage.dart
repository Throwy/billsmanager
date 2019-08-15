import 'package:billsmanager/pages/settings/ThemeSettingsPage.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  SettingsPageState createState() => new SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  TextStyle _style = TextStyle(fontSize: 22.0);

  List<String> _settingsItems = ["Theme"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: _settingsItems.map<ListTile>((title) {
          return ListTile(
            title: Text(
              title,
              style: _style,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ThemeSettingsPage(
                  title: title,
                  brightness: Theme.of(context).brightness,
                ),
              ),
            ),
          );
        }).toList()        
      ),
    );
  }
}

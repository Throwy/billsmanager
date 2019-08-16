import 'package:billsmanager/models/SettingsItem.dart';
import 'package:billsmanager/pages/settings/ThemeSettingsPage.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final TextStyle _style = TextStyle(fontSize: 22.0);

  final List<SettingsItem> _settingsItems = [
    new SettingsItem("Theme", new ThemeSettingsPage())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView.builder(
        itemCount: _settingsItems.length,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          return ListTile(
            title: Text(
              _settingsItems[index].title,
              style: _style,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      _settingsItems[index].widget),
            ),
          );
        },
      ),
    );
  }
}

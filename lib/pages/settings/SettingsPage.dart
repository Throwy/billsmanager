import 'package:billsmanager/models/SettingsItem.dart';
import 'package:billsmanager/pages/settings/BillsSettingsPage.dart';
import 'package:billsmanager/pages/settings/ThemeSettingsPage.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final TextStyle _style = TextStyle(fontSize: 22.0);

  final List<SettingsItem> _settingsItems = [
    new SettingsItem("Theme", new ThemeSettingsPage()),
    new SettingsItem("Bills", new BillsSettingsPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView.separated(
        itemCount: _settingsItems.length,
        separatorBuilder: (context, i) {
          return Divider();
        },
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(
              _settingsItems[i].title,
              style: _style,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => _settingsItems[i].widget),
            ),
          );
        },
      ),
    );
  }
}

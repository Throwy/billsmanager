import 'package:flutter/material.dart';

/// Helper class to model items that belong in the settings page.
class SettingsItem {
  String title;
  Widget widget;
  SettingsItem(this.title, this.widget);
}
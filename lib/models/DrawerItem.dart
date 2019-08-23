import 'package:flutter/material.dart';

/// Helper class to model items that belong in the app drawer.
class DrawerItem {
  String title;
  IconData icon;
  Widget widget;
  DrawerItem(this.title, this.icon, this.widget);
}
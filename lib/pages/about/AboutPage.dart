import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.payment),
              Text("Bills Manager"),
              Text("Version 1.0.0"),
              Divider(),
              Text("Developed by"),
              Text("Gavin Roudebush (Throwy)"),
              Text("Copyright 2019, All rights reserved."),
            ],
          )
        ],
      ),
    );
  }
}
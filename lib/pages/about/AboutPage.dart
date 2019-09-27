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
              Container(
                margin: EdgeInsets.only(top: 60.0),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.payment,
                      color: Theme.of(context).accentColor,
                      size: 100.0,
                    ),
                    Text(
                      "Bills Manager",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Version 1.0.0"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Divider(),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text("Developed by"),
                    Text("Gavin Roudebush (Throwy)\n"),
                    Text("Copyright 2019, All rights reserved."),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

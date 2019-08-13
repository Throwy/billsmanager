import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  HistoryPageState createState() => new HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
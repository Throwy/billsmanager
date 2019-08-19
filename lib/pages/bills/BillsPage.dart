import 'package:billsmanager/pages/bills/CalendarPage.dart';
import 'package:flutter/material.dart';

class BillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bills"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CalendarPage(),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}

import 'package:billsmanager/pages/bills/CalendarPage.dart';
import 'package:billsmanager/store/BillsState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
      body: ScopedModelDescendant<BillsState>(
        builder: (context, child, model) {
          return ListView(
            children: model.bills.map((bill) {
              return ListTile(
                title: Text(bill.title),
                subtitle: Text(bill.dueOn.toLocal().toString()),
                trailing: Text(bill.amountDue),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

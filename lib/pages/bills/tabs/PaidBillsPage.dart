import 'package:billsmanager/store/BillsState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PaidBillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<BillsState>(
      builder: (context, child, model) {
        return ListView(
          children: model
              .getPaidBills()
              .map((bill) => ListTile(
                    leading: Icon(Icons.payment),
                    title: Text(bill.billType),
                    subtitle: Text(
                        "${bill.dueOn.month}/${bill.dueOn.day}/${bill.dueOn.year}"),
                  ))
              .toList(),
        );
      },
    );
  }
}

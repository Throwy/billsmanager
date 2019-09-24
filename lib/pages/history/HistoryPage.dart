import 'package:billsmanager/store/PaymentsState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      body: ScopedModelDescendant<PaymentsState>(
        builder: (context, child, model) {
          return ListView(
            children: model.payments
                .map(
                  (payment) => Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.payment),
                        title: Text("\$${payment.amountPaid}"),
                        subtitle: Text(
                            "${payment.paidOn.month}/${payment.paidOn.day}/${payment.paidOn.year}"),
                      ),
                      Divider(
                        height: 0.0,
                      ),
                    ],
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

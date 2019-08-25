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
          return Container(
            child: Column(
              children: <Widget>[
                ListView(
                  children: model.payments
                      .map(
                        (payment) => ListTile(
                          title: Text("\$${payment.amountPaid}"),
                          subtitle: Text(payment.paidOn.toLocal().toString()),
                        ),
                      )
                      .toList(),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

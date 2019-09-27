import 'package:billsmanager/pages/shared/BillDetailsPage.dart';
import 'package:billsmanager/store/AppState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PaidBillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppState>(
      builder: (context, child, model) {
        return ListView(
          children: model.billsState
              .getPaidBills()
              .map(
                (bill) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.check),
                      title: Text(bill.billType),
                      subtitle: Text(
                          "${bill.dueOn.month}/${bill.dueOn.day}/${bill.dueOn.year}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillDetailsPage(
                              bill: bill,
                            ),
                          ),
                        );
                      },
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
    );
  }
}

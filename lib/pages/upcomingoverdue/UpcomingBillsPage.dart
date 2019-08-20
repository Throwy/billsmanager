import 'package:billsmanager/store/BillsState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'BillItem.dart';

class UpcomingBillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<BillsState>(
      builder: (context, child, model) {
        return ListView(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          children: <Widget>[
            Column(
                mainAxisSize: MainAxisSize.max,
                children: model
                    .getUpcomingBills()
                    .map((bill) => BillItem(
                          bill: bill,
                          overDue: false,
                        ))
                    .toList()),
          ],
        );
      },
    );
  }
}

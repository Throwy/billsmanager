import 'package:billsmanager/models/Bill.dart';
import 'package:billsmanager/pages/landing/tabs/BillItem.dart';
import 'package:flutter/material.dart';

class OverdueBillsPage extends StatelessWidget {
  final List<Bill> overdueBills;

  const OverdueBillsPage({Key key, @required this.overdueBills})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      children: <Widget>[
        Column(
            mainAxisSize: MainAxisSize.max,
            children: overdueBills
                .map((bill) => BillItem(
                      bill: bill,
                      overDue: true,
                    ))
                .toList()),
      ],
    );
  }
}

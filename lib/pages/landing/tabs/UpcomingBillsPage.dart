import 'package:billsmanager/models/Bill.dart';
import 'package:flutter/material.dart';

import 'BillItem.dart';

class UpcomingBillsPage extends StatelessWidget {
  final List<Bill> upcomingBills;

  const UpcomingBillsPage({Key key, @required this.upcomingBills})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      children: <Widget>[
        Column(
            mainAxisSize: MainAxisSize.max,
            children: upcomingBills
                .map((bill) => BillItem(
                      bill: bill,
                      overDue: false,
                    ))
                .toList()),
      ],
    );
  }
}

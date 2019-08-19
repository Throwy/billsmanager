import 'package:billsmanager/pages/upcoming/BillItem.dart';
import 'package:flutter/material.dart';

class UpcomingBillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            BillItem(),
            BillItem(),
            BillItem(),
            BillItem(),
          ],
        ),
      ],
    );
  }
}

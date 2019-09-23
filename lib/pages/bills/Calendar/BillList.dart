import 'package:billsmanager/models/Bill.dart';
import 'package:flutter/material.dart';

class BillList extends StatelessWidget {
  final List<Bill> bills;

  const BillList({Key key, @required this.bills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: bills
            .map(
              (b) => Container(
                margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                width: MediaQuery.of(context).size.width,
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: ListTile(
                      title: Text(b.title),
                      trailing: Text("\$${b.amountDue}"),
                      subtitle: Text(b.billType),
                    ),
                  ),
                ),
              ),
            )
            .toList());
  }
}

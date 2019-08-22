import 'package:billsmanager/store/BillsState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UnpaidBillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<BillsState>(
      builder: (context, child, model) {
        return ListView(
          children: model.getUnpaidBills().map((bill) {
            bool overDue = bill.dueOn.millisecondsSinceEpoch <
                DateTime.now()
                    .subtract(Duration(days: 1))
                    .millisecondsSinceEpoch;
            DateTime now = DateTime.now();
            bool sameDate = (bill.dueOn.year == now.year) &&
                (bill.dueOn.month == now.month) &&
                (bill.dueOn.day == now.day);

            Icon leading = Icon(Icons.attach_money);
            String subTitle =
                "${bill.dueOn.month}/${bill.dueOn.day}/${bill.dueOn.year}";
            if (sameDate) {
              leading = Icon(Icons.warning, color: Colors.yellow);
              subTitle = "Today  >  Pay Now";
            } else if (overDue) {
              leading = Icon(Icons.warning, color: Colors.redAccent);
              subTitle = "Overdue  >  Pay Now!";
            }

            return Column(
              children: <Widget>[
                ListTile(
                  leading: leading,
                  title: Text(
                    bill.billType,
                  ),
                  subtitle: Text(
                    subTitle,
                  ),
                ),
                Divider(),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}

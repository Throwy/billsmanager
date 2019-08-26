import 'package:billsmanager/helpers/utilities.dart' as utilities;
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
            bool overDue = utilities.overDue(bill.dueOn);
            bool sameDate = utilities.sameDate(bill.dueOn, DateTime.now());

            Icon leading = Icon(Icons.attach_money);
            String subTitle = utilities.billItemDueInSubtitle(bill.dueOn);
            if (sameDate) {
              leading = Icon(Icons.warning, color: Colors.yellow);
              subTitle = "Today  >  Pay Today";
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

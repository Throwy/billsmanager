import 'package:billsmanager/helpers/utilities.dart' as utilities;
import 'package:billsmanager/pages/shared/BillDetailsPage.dart';
import 'package:billsmanager/store/AppState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UnpaidBillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppState>(
      builder: (context, child, model) {
        return ListView(
          children: model.billsState.getUnpaidBills().map((bill) {
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
            );
          }).toList(),
        );
      },
    );
  }
}

import 'package:billsmanager/helpers/utilities.dart' as utilities;
import 'package:billsmanager/models/Bill.dart';
import 'package:billsmanager/models/Payment.dart';
import 'package:billsmanager/pages/shared/BillDetailsPage.dart';
import 'package:billsmanager/store/BillsState.dart';
import 'package:billsmanager/store/PaymentsState.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BillItem extends StatelessWidget {
  final Bill bill;
  final bool overDue;

  BillItem({Key key, @required this.bill, @required this.overDue});

  @override
  Widget build(BuildContext context) {
    bool sameDate = utilities.sameDate(bill.dueOn, DateTime.now());
    String subTitle = utilities.billItemDueInSubtitle(bill.dueOn);

    if (sameDate) {
      subTitle = "Today  >  Pay Today";
    } else if (overDue) {
      subTitle = "Overdue  >  Pay Now!";
    }

    return Container(
      margin: EdgeInsets.fromLTRB(0, 5.0, 0.0, 5.0),
      width: MediaQuery.of(context).size.width,
      child: Card(
        borderOnForeground: false,
        shape: overDue
            ? RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.red,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
              )
            : RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).cardColor,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
        child: InkWell(
          borderRadius: BorderRadius.circular(4.0),
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
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        bill.title,
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      Text(
                        bill.billType,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .subtitle
                              .color
                              .withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "\$${bill.amountDue}",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    RaisedButton(
                      splashColor: Colors.teal,
                      child: Text(
                        "Pay",
                        style: TextStyle(
                          color: Theme.of(context).accentTextTheme.button.color,
                        ),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                                  Text("Pay full amount? \$${bill.amountDue}"),
                              actions: <Widget>[
                                Row(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text("CANCEL"),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    FlatButton(
                                      child: Text("PAY"),
                                      onPressed: () {
                                        ScopedModel.of<BillsState>(context)
                                            .payFullAmount(bill)
                                            .then((res) {
                                          ScopedModel.of<PaymentsState>(context)
                                              .addPayment(Payment.withValues(
                                                  null,
                                                  bill.id,
                                                  bill.amountDue,
                                                  DateTime.now()));
                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:billsmanager/models/BIll.dart';
import 'package:flutter/material.dart';

class BillItem extends StatelessWidget {
  final Bill bill;
  final bool overDue;

  BillItem({Key key, @required this.bill, @required this.overDue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5.0, 0.0, 5.0),
      width: MediaQuery.of(context).size.width,
      //height: 120.0,
      child: Card(
        shape: overDue
            ? RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.red,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
              )
            : RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).cardColor,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
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
                      "${bill.dueOn.month}/${bill.dueOn.day}/${bill.dueOn.year}  >  Pay Now",
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
                            title: Text("Pay full amount?"),
                            actions: <Widget>[
                              Row(
                                children: <Widget>[
                                  FlatButton(
                                    child: Text("CANCEL"),
                                    onPressed: () => print("cancel"),
                                  ),
                                  FlatButton(
                                    child: Text("PAY"),
                                    onPressed: () => print("pay all"),
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
    );
  }
}

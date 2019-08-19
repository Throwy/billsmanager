import 'package:flutter/material.dart';

class BillItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5.0, 0.0, 5.0),
      width: MediaQuery.of(context).size.width,
      //height: 120.0,
      child: Card(
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
                      "Car bill",
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    Text(
                      "Car Loan",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      "Today  >  Pay Now",
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
                    "\$300.00",
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
                    onPressed: () => print("pay button"),
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

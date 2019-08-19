import 'package:flutter/material.dart';

class BillItem extends StatelessWidget {
  final TextStyle _titleStyle = TextStyle(fontSize: 22.0);
  final TextStyle _billTypeStyle = TextStyle(fontSize: 16.0);
  final TextStyle _amountDueStyle = TextStyle(fontSize: 16.0);
  final TextStyle _dueOnStyle = TextStyle(color: Colors.white60);

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
                      style: _titleStyle,
                    ),
                    Text(
                      "Car Loan",
                      style: _billTypeStyle,
                    ),
                    Text(
                      "Today  >  Pay Now",
                      style: _dueOnStyle,
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    "\$300.00",
                    style: _amountDueStyle,
                  ),
                  RaisedButton(
                    child: Text("Pay"),
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

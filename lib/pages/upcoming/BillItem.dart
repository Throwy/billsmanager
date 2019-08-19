import 'package:flutter/material.dart';

class BillItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10.0, 0.0, 10.0),
      width: MediaQuery.of(context).size.width,
      height: 120.0,
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
                    Text("Title"),
                    Text("Due On"),
                    Text("Bill Type")
                  ],
                ),
              ),
              Container(
                child: Text("Amount Due"),
                margin: EdgeInsets.only(right: 5.0),
              ),
              Container(
                //color: Colors.blue,
                child: RaisedButton(
                  child: Text("Pay"),
                  color: Colors.green,
                  onPressed: () => print("pay button"),
                ),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     FlatButton(
              //       child: Text("Pay"),
              //       color: Colors.green,
              //       onPressed: () => print("pay button"),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

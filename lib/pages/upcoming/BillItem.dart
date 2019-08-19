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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Title"),
            ],
          ),
        ),
      ),
    );
  }
}

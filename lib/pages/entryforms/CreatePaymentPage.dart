import 'package:flutter/material.dart';

class CreatePaymentPage extends StatefulWidget {
  CreatePaymentPageState createState() => new CreatePaymentPageState();
}

class CreatePaymentPageState extends State<CreatePaymentPage> {
  final String _title = "Add Payment";

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              //Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          
        ],
      ),
    );
  }
}

import 'package:billsmanager/helpers/utilities.dart' as utilities;
import 'package:billsmanager/models/Bill.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillDetailsPage extends StatefulWidget {
  final Bill bill;

  const BillDetailsPage({Key key, @required this.bill}) : super(key: key);

  BillDetailsPageState createState() => new BillDetailsPageState();
}

class BillDetailsPageState extends State<BillDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {

            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildHeader(),
            Divider(),
            !widget.bill.paid ? _buildDueRow() : _buildPaidRow(),
            Divider(),
            Expanded(
              flex: 1,
              child: _buildNotesSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      child: ListTile(
        title: Text(
          widget.bill.title,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.bill.billType,
          style: TextStyle(),
        ),
      ),
    );
  }

  Widget _buildDueRow() {
    String dueOn = DateFormat.yMMMMd().format(widget.bill.dueOn);
    bool overDue = utilities.overDue(widget.bill.dueOn);
    bool sameDate = utilities.sameDate(widget.bill.dueOn, DateTime.now());

    String top = widget.bill.dueOn.difference(DateTime.now()).inDays.toString();
    String bottom = "Days to Pay";
    TextStyle style = TextStyle(color: Theme.of(context).textTheme.body1.color);
    if (sameDate) {
      top = "Due Today";
      bottom = "Pay Now";
    } else if (overDue) {
      top = DateTime.now().difference(widget.bill.dueOn).inDays.toString();
      bottom = "Days past";
      style = TextStyle(color: Colors.red[400]);
    }

    return Container(
      child: ListTile(
        title: Text("\$${widget.bill.amountDue}"),
        subtitle: Text("By $dueOn"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              top,
              style: style,
            ),
            Text(
              bottom,
              style: style,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaidRow() {
    return Container(
      child: ListTile(
        title: Text("\$${widget.bill.amountDue}"),
        subtitle: Text("Paid"),
        trailing: Icon(Icons.check_circle),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(widget.bill.notes),
          ),
        ],
      ),
    );
  }
}

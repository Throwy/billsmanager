import 'package:billsmanager/pages/bills/CalendarPage.dart';
import 'package:billsmanager/pages/bills/tabs/PaidBillsPage.dart';
import 'package:billsmanager/pages/bills/tabs/UnpaidBillsPage.dart';
import 'package:flutter/material.dart';

class BillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bills"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CalendarPage(),
              ),
            ),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Theme.of(context).primaryColorDark,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    TabBar(
                      tabs: <Widget>[
                        Tab(
                          text: "Unpaid",
                        ),
                        Tab(
                          text: "Paid",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              UnpaidBillsPage(),
              PaidBillsPage(),
            ],
          ),
        ),
      ),
      // body: ScopedModelDescendant<BillsState>(
      //   builder: (context, child, model) {
      //     return ListView(
      //       children: model.bills.map((bill) {
      //         return ListTile(
      //           title: Text(bill.title),
      //           subtitle: Text(bill.dueOn.toLocal().toString()),
      //           trailing: Text(bill.amountDue),
      //         );
      //       }).toList(),
      //     );
      //   },
      // ),
    );
  }
}

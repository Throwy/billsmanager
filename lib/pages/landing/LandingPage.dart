import 'package:billsmanager/models/DrawerItem.dart';
import 'package:billsmanager/pages/bills/BillsPage.dart';
import 'package:billsmanager/pages/entryforms/CreateBillPage.dart';
import 'package:billsmanager/pages/entryforms/CreatePaymentPage.dart';
import 'package:billsmanager/pages/history/HistoryPage.dart';
import 'package:billsmanager/pages/landing/tabs/OverdueBillsPage.dart';
import 'package:billsmanager/pages/landing/tabs/UpcomingBillsPage.dart';
import 'package:billsmanager/pages/settings/SettingsPage.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  final List<DrawerItem> _drawerItems = [
    new DrawerItem("Bills", Icons.attach_money, BillsPage()),
    new DrawerItem("History", Icons.history, HistoryPage()),
    new DrawerItem("Settings", Icons.settings, SettingsPage()),
  ];

  List<ListTile> _drawerTiles;

  @override
  void initState() {
    super.initState();

    _drawerTiles = _drawerItems.map<ListTile>((DrawerItem item) {
      return ListTile(
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => item.widget,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              // decoration: BoxDecoration(
              //   color: Theme.of(context).primaryColor,
              // ),
              margin: EdgeInsets.zero,
              child: Center(
                child: Text("Bills Manager"),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: _drawerTiles,
              ),
            )
          ],
        ),
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
                          text: "Upcoming",
                        ),
                        Tab(
                          text: "Overdue",
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
              UpcomingBillsPage(),
              OverdueBillsPage(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.attach_money),
                  title: Text("Add Bill"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateBillPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text("Add Payment"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatePaymentPage(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
        tooltip: 'Create Entry',
        child: Icon(Icons.add),
      ),
    );
  }
}

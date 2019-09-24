import 'package:badges/badges.dart';
import 'package:billsmanager/models/DrawerItem.dart';
import 'package:billsmanager/pages/about/AboutPage.dart';
import 'package:billsmanager/pages/bills/BillsPage.dart';
import 'package:billsmanager/pages/entryforms/BillFormPage.dart';
import 'package:billsmanager/pages/entryforms/CreatePaymentPage.dart';
import 'package:billsmanager/pages/history/HistoryPage.dart';
import 'package:billsmanager/pages/landing/tabs/OverdueBillsPage.dart';
import 'package:billsmanager/pages/landing/tabs/UpcomingBillsPage.dart';
import 'package:billsmanager/pages/settings/SettingsPage.dart';
import 'package:billsmanager/store/BillsState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
    new DrawerItem("About", Icons.info, AboutPage()),
  ];

  List<ListTile> _drawerTiles;

  @override
  void initState() {
    super.initState();

    _drawerTiles = _drawerItems.map<ListTile>((DrawerItem item) {
      return ListTile(
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => item.widget,
            ),
          );
        },
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
      body: ScopedModelDescendant<BillsState>(
        builder: (context, child, model) {
          var upcomingBills = model.getUpcomingBills();
          var overdueBills = model.getOverdueBills();

          return DefaultTabController(
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Upcoming",
                                    style: TextStyle()
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0),
                                    child: Badge(
                                      badgeContent: Text(
                                        upcomingBills.length.toString(),
                                        style: TextStyle().copyWith(
                                          color: Theme.of(context)
                                              .accentTextTheme
                                              .button
                                              .color,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      badgeColor: Theme.of(context).accentColor,
                                      animationType: BadgeAnimationType.scale,
                                      animationDuration:
                                          Duration(milliseconds: 150),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Overdue",
                                    style: TextStyle()
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 5.0),
                                    child: Badge(
                                      badgeContent: Text(
                                        overdueBills.length.toString(),
                                        style: TextStyle().copyWith(
                                          color: Theme.of(context)
                                              .accentTextTheme
                                              .button
                                              .color,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      badgeColor: Theme.of(context).accentColor,
                                      animationType: BadgeAnimationType.scale,
                                      animationDuration:
                                          Duration(milliseconds: 150),
                                    ),
                                  ),
                                ],
                              ),
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
                  UpcomingBillsPage(
                    upcomingBills: upcomingBills,
                  ),
                  OverdueBillsPage(
                    overdueBills: overdueBills,
                  ),
                ],
              ),
            ),
          );
        },
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
                        builder: (context) => BillFormPage(
                          title: "Add Bill",
                        ),
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

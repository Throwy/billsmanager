import 'package:billsmanager/models/DrawerItem.dart';
import 'package:billsmanager/pages/entryforms/CreateBillPage.dart';
import 'package:billsmanager/pages/history/HistoryPage.dart';
import 'package:billsmanager/pages/settings/SettingsPage.dart';
import 'package:billsmanager/store/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(App(
    state: ThemeState(preferences: preferences),
  ));
}

class App extends StatelessWidget {
  final ThemeState state;

  const App({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeState>(
      model: state,
      child: ScopedModelDescendant<ThemeState>(
        builder: (context, child, model) {
          return MaterialApp(
            title: 'Bills Manager',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              brightness: model.brightness,
            ),
            home: LandingPage(title: 'Bills Manager'),
          );
        },
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  final List<DrawerItem> _drawerItems = [
    new DrawerItem("History", Icons.history, HistoryPage()),
    new DrawerItem("Settings", Icons.settings, SettingsPage())
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
      body: Center(),
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
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateBillPage(),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text("Add Payment"),
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

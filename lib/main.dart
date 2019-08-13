import 'package:billsmanager/helpers/AppBuilder.dart';
import 'package:billsmanager/models/DrawerItem.dart';
import 'package:billsmanager/pages/entryforms/CreateBillPage.dart';
import 'package:billsmanager/pages/history/HistoryPage.dart';
import 'package:billsmanager/pages/settings/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      builder: (BuildContext context) {
        return DynamicTheme(
          defaultBrightness: Brightness.light,
          data: (brightness) => ThemeData(
            primarySwatch: Colors.blue,
            brightness: brightness,
          ),
          themedWidgetBuilder: (context, theme) {
            return MaterialApp(
              title: 'Bills Manager',
              theme: theme,
              home: LandingPage(title: 'Bills Manager'),
            );
          },
        );
      },
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

  @override
  void initState() {
    super.initState();
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
                children: _drawerItems.map<ListTile>((DrawerItem item) {
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
                }).toList(),
              ),
            )
          ],
        ),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showModalBottomSheet(
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
          )
        },
        tooltip: 'Create Entry',
        child: Icon(Icons.add),
      ),
    );
  }
}

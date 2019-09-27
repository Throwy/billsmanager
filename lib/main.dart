import 'package:billsmanager/helpers/DBProvider.dart';
import 'package:billsmanager/pages/landing/LandingPage.dart';
import 'package:billsmanager/store/AppState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var db = await DBProvider.db.database;
  runApp(App(
    appState: await AppState(preferences: preferences, database: db).initAppState(),
  ));
}

class App extends StatelessWidget {
  final AppState appState;

  const App({
    Key key,
    @required this.appState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScopedModel<AppState>(
      model: appState,
      child: ScopedModelDescendant<AppState>(
        builder: (context, child, model) {
          return MaterialApp(
            title: 'Bills Manager',
            theme: ThemeData(
              primarySwatch: Colors.teal,
              accentColor: model.themeState.brightness == Brightness.dark
                  ? Colors.tealAccent
                  : Colors.deepPurple,
              brightness: model.themeState.brightness,
            ),
            home: LandingPage(
              title: 'Bills Manager',
            ),
          );
        },
      ),
    );
  }
}

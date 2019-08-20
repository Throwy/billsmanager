import 'package:billsmanager/pages/landing/LandingPage.dart';
import 'package:billsmanager/store/BillsState.dart';
import 'package:billsmanager/store/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(App(
    themeState: ThemeState(preferences: preferences),
    billsState: BillsState(),
  ));
}

class App extends StatelessWidget {
  final ThemeState themeState;
  final BillsState billsState;

  const App({Key key, @required this.themeState, @required this.billsState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeState>(
      model: themeState,
      child: ScopedModelDescendant<ThemeState>(
        builder: (context, child, model) {
          return ScopedModel<BillsState>(
            model: billsState,
            child: MaterialApp(
              title: 'Bills Manager',
              theme: ThemeData(
                primarySwatch: Colors.teal,
                brightness: model.brightness,
              ),
              home: LandingPage(
                title: 'Bills Manager',
              ),
            ),
          );
        },
      ),
    );
  }
}


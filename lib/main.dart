import 'dart:io';

import 'package:billsmanager/helpers/DBProvider.dart';
import 'package:billsmanager/pages/landing/LandingPage.dart';
import 'package:billsmanager/store/BillsState.dart';
import 'package:billsmanager/store/PaymentsState.dart';
import 'package:billsmanager/store/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var db = await DBProvider.db.database;
  runApp(App(
    themeState: ThemeState(preferences: preferences).initThemeState(),
    billsState: await BillsState(database: db).initBillsState(),
    paymentsState: await PaymentsState(database: db).initPaymentsState(),
  ));
}

class App extends StatelessWidget {
  final ThemeState themeState;
  final BillsState billsState;
  final PaymentsState paymentsState;

  const App({Key key, @required this.themeState, @required this.billsState, @required this.paymentsState}) : super(key: key);

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
                accentColor: model.brightness == Brightness.dark ? Colors.tealAccent : Colors.deepOrange,
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


import 'package:billsmanager/store/BillsState.dart';
import 'package:billsmanager/store/PaymentsState.dart';
import 'package:billsmanager/store/ThemeState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends Model with ThemeState, BillsState, PaymentsState {
  final SharedPreferences preferences;
  final Database database;
  
  ThemeState themeState;
  BillsState billsState;
  PaymentsState paymentsState;

  AppState({Key key, @required this.preferences, @required this.database});

  initAppState() async {
    themeState = await this.initThemeState(preferences);
    billsState = await this.initBillsState(database);
    paymentsState = await this.initPaymentsState(database);

    return this;
  }
}
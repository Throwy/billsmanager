import 'package:billsmanager/models/Payment.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';

class PaymentsState extends Model {
  final Database database;
  List<Payment> _payments;

  PaymentsState({Key key, @required this.database}) {
    _payments = new List<Payment>();
  }

  initPaymentsState() async {
    List<Map<String, dynamic>> res = await database.query("payments");
    _payments = res.isNotEmpty
        ? res.map((payment) => Payment.fromMap(payment)).toList()
        : [];
    return this;
  }

  List<Payment> get payments => _payments;
}

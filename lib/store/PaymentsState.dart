import 'package:billsmanager/models/Payment.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';

/// Models the app state regarding payments.
///
/// This class holds all of the payments created by the user in the app.
///
/// There are multiple methods for retrieving payments based on different
/// parameters.
class PaymentsState extends Model {
  final Database database;
  List<Payment> _payments;

  PaymentsState({Key key, @required this.database}) {
    _payments = new List<Payment>();
  }

  /// Intializes the [PaymentsState] class.
  ///
  /// This should only be called once, ie. when the app is being opened.
  initPaymentsState() async {
    List<Map<String, dynamic>> res = await database.query("payments");
    _payments = res.isNotEmpty
        ? res.map((payment) => Payment.fromMap(payment)).toList()
        : [];
    return this;
  }

  /// Gets all of the [Payment]s.
  List<Payment> get payments => _payments;

  /// Returns a [Payment] from the collection with the given [id].
  Payment getPayment(int id) {
    return _payments.firstWhere((payment) => payment.id == id);
  }

  /// Returns a [List<Payment>] for the given [Bill].[id].
  List<Payment> getPaymentsByBill(int billId) {
    var list = _payments.where((payment) => payment.billId == billId).toList();
    return list;
  }

  /// Adds one [Payment] to the collection.
  void addPayment(Payment payment) async {
    await database.insert("payments", payment.toMap()).then((value) {
      _payments.add(payment);
      notifyListeners();
    });
  }

  /// Deletes one [Payment] from the collection.
  void deletePayment(int id) async {
    await database
        .delete("payments", where: "id = ?", whereArgs: [id]).then((value) {
      _payments.removeWhere((payment) => payment.id == id);
      notifyListeners();
    });
  }

  /// Helper function to call from anywhere in the tree.
  static PaymentsState of(BuildContext context) =>
      ScopedModel.of<PaymentsState>(context);
}

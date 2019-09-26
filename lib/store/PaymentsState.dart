import 'package:billsmanager/models/Payment.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sembast/sembast.dart';

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

  /// Intializes the `PaymentsState` class.
  ///
  /// This should only be called once, ie. when the app is being opened.
  initPaymentsState() async {
    var store = intMapStoreFactory.store('payments');
    var res = await store.find(database, finder: Finder());
    _payments = res.isNotEmpty
        ? res.map((payment) => Payment.fromMap(payment)).toList()
        : [];
    return this;
  }

  /// Gets all of the `Payment`s.
  List<Payment> get payments => _payments;

  /// Returns a `Payment` from the collection with the given [id].
  Payment getPayment(int id) {
    return _payments.firstWhere((payment) => payment.id == id);
  }

  /// Returns a `List<Payment>` for the given [billid].
  List<Payment> getPaymentsByBill(int billId) {
    var list = _payments.where((payment) => payment.billId == billId).toList();
    return list != null ? list : [];
  }

  /// Adds one `Payment` to the database and updates the collection.
  Future<void> addPayment(Payment payment) async {
    var store = intMapStoreFactory.store('payments');
    
    int paymentKey;
    await database.transaction((trans) async {
      paymentKey = await store.add(trans, payment.toMap());
    }).then((res) {
      payment.id = paymentKey;
      _payments.add(payment);
      notifyListeners();
    });
  }

  /// Deletes one `Payment` from the database and updates the collection.
  Future<void> deletePayment(int paymentId) async {
    var store = intMapStoreFactory.store('payments');
    var record = store.record(paymentId);

    await database.transaction((trans) async {
      await record.delete(trans);
    }).then((res) {
      _payments.removeWhere((payment) => payment.id == paymentId);
      notifyListeners();
    });
  }

  /// Helper function to call from anywhere in the tree.
  static PaymentsState of(BuildContext context) =>
      ScopedModel.of<PaymentsState>(context);
}

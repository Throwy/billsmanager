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
mixin PaymentsState on Model {
  Database _database;
  List<Payment> _payments;

  // store name
  static const String PAYMENTS_STORE_NAME = "payments";

  // create the store
  final _paymentsStore = intMapStoreFactory.store(PAYMENTS_STORE_NAME);

  /// Intializes the `PaymentsState` class.
  ///
  /// This should only be called once, ie. when the app is being opened.
  Future<PaymentsState> initPaymentsState(Database database) async {
    _database = database;

    var res = await _paymentsStore.find(_database, finder: Finder());
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
    int paymentKey;
    await _database.transaction((trans) async {
      paymentKey = await _paymentsStore.add(trans, payment.toMap());
    }).then((res) {
      payment.id = paymentKey;
      _payments.add(payment);
      notifyListeners();
    });
  }

  /// Deletes one `Payment` from the database and updates the collection.
  Future<void> deletePayment(int paymentId) async {
    var record = _paymentsStore.record(paymentId);

    await _database.transaction((trans) async {
      await record.delete(trans);
    }).then((res) {
      _payments.removeWhere((payment) => payment.id == paymentId);
      notifyListeners();
    });
  }

  /// Deletes all `Payment`s for then given billId.
  Future<void> deletePaymentsForBill(int billId) async {
    await _database.transaction((trans) async {
      var filter = Filter.equals("bill_id", billId);
      var finder = Finder(filter: filter);
      return await _paymentsStore.delete(trans, finder: finder);
    }).then((res) {
      _payments.removeWhere((p) => p.billId == billId);
      notifyListeners();
    });
  }

  /// Helper function to call from anywhere in the tree.
  static PaymentsState of(BuildContext context) =>
      ScopedModel.of<PaymentsState>(context);
}

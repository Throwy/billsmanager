import 'package:billsmanager/helpers/utilities.dart' as utilities;
import 'package:billsmanager/models/Bill.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';

/// Models the app state regarding bills.
///
/// This class holds all of the bills created by the user in the app.
///
/// There are multiple methods for retrieving bills based on different
/// parameters.
class BillsState extends Model {
  final Database database;
  List<Bill> _bills;

  BillsState({Key key, @required this.database}) {
    _bills = new List<Bill>();
  }

  /// Initializes the [BillsState] class.
  ///
  /// This should only be called once, ie. when the app is being opened.
  initBillsState() async {
    List<Map<String, dynamic>> res = await database.query("bills");
    _bills =
        res.isNotEmpty ? res.map((bill) => Bill.fromMap(bill)).toList() : [];
    return this;
  }

  /// Gets all of the [Bill]s.
  List<Bill> get bills => _bills;

  /// Gets a [Bill] from the collection with the given [id].
  Bill getBill(int id) {
    return _bills.firstWhere((bill) => bill.id == id);
  }

  /// Gets all upcoming [Bill]s, including ones due today.
  List<Bill> getUpcomingBills() {
    var miliNow = DateTime.now().millisecondsSinceEpoch;
    var miliExtended =
        DateTime.now().add(Duration(days: 7)).millisecondsSinceEpoch;
    var list = _bills
        .where((bill) =>
            ((bill.dueOn.millisecondsSinceEpoch >= miliNow) ||
                utilities.sameDate(bill.dueOn, DateTime.now())) &&
            (bill.dueOn.millisecondsSinceEpoch <= miliExtended) &&
            (!bill.paid))
        .toList();
    list.sort((a, b) => a.dueOn.millisecondsSinceEpoch
        .compareTo(b.dueOn.millisecondsSinceEpoch));
    return list;
  }

  /// Gets all overdue [Bill]s.
  List<Bill> getOverdueBills() {
    DateTime now = DateTime.now();
    var list = _bills
        .where((bill) =>
            (bill.dueOn.millisecondsSinceEpoch < now.millisecondsSinceEpoch) &&
            !utilities.sameDate(bill.dueOn, DateTime.now()))
        .toList();
    list.sort((a, b) => a.dueOn.millisecondsSinceEpoch
        .compareTo(b.dueOn.millisecondsSinceEpoch));
    return list;
  }

  /// Gets all unpaid [Bill]s.
  List<Bill> getUnpaidBills() {
    var list = _bills.where((bill) => !bill.paid).toList();
    list.sort((a, b) => a.dueOn.millisecondsSinceEpoch
        .compareTo(b.dueOn.millisecondsSinceEpoch));
    return list;
  }

  /// Gets all paid [Bill]s.
  List<Bill> getPaidBills() {
    var list = _bills.where((bill) => bill.paid).toList();
    list.sort((a, b) => a.dueOn.millisecondsSinceEpoch
        .compareTo(b.dueOn.millisecondsSinceEpoch));
    return list;
  }

  /// Adds one [Bill] to the database and updates the collection.
  void addBill(Bill bill) async {
    await database.insert("bills", bill.toMap()).then((value) {
      bill.id = value;
      _bills.add(bill);
      notifyListeners();
    });
  }

  /// Adds multiple [Bill]s to the database and updates the collection.
  void addBills(List<Bill> bills) {
    _bills.addAll(bills);
    notifyListeners();
  }

  /// Sets the value of paid to [true] for the specified [Bill] in the database.
  Future<void> payFullAmount(Bill bill) async {
    await database.transaction((txn) async {
      await txn.update(
        "bills",
        {'paid': 1},
        where: 'id = ?',
        whereArgs: [bill.id],
      );
    }).then((value) {
      _bills.firstWhere((bill) => bill.id == bill.id).paid = true;
      notifyListeners();
    });
  }

  /// Deletes a single [Bill] from the database and updates the collection.
  void deleteBill(int id) async {
    await database
        .delete("bills", where: 'id = ?', whereArgs: [id]).then((value) {
      _bills.removeWhere((bill) => bill.id == id);
      notifyListeners();
    });
  }

  /// Deletes multiple [Bill]s from the database and updates the collection.
  void deleteBills(List<int> ids) {
    _bills.removeWhere((bill) => ids.contains(bill.id));
    notifyListeners();
  }

  /// Helper function to call from anywhere in the tree.
  static BillsState of(BuildContext context) =>
      ScopedModel.of<BillsState>(context);
}

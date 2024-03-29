import 'package:billsmanager/helpers/utilities.dart' as utilities;
import 'package:billsmanager/models/Bill.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Models the app state regarding bills.
///
/// This class holds all of the bills created by the user in the app.
///
/// There are multiple methods for retrieving bills based on different
/// parameters.
mixin BillsState on Model {
  SharedPreferences _preferences;
  int _upcomingBillPeriod;
  Database _database;
  List<Bill> _bills;

  // store name
  static const String BILLS_STORE_NAME = "bills";

  // Create the store
  final _billsStore = intMapStoreFactory.store(BILLS_STORE_NAME);

  /// Initializes the `BillsState` class.
  ///
  /// This should only be called once, ie. when the app is being opened.
  Future<BillsState> initBillsState(
      SharedPreferences preferences, Database database) async {
    _preferences = preferences;
    _database = database;

    try {
      if (preferences.containsKey("upcomingBillPeriod")) {
        _upcomingBillPeriod = _preferences.getInt("upcomingBillPeriod");
      } else {
        _upcomingBillPeriod = 7;
      }
    } catch (e) {
      _upcomingBillPeriod = 7;
    }

    var res = await _billsStore.find(_database, finder: Finder());

    _bills =
        res.isNotEmpty ? res.map((bill) => Bill.fromMap(bill)).toList() : [];
    return this;
  }

  /// Gets all of the `Bill`s.
  List<Bill> get bills => _bills;

  /// Gets the number of days to look ahead for upcoming bills.
  int get upcomingBillPeriod => _upcomingBillPeriod;

  /// Gets a `Bill` from the collection with the given [id].
  Bill getBill(int id) {
    return _bills.firstWhere((bill) => bill.id == id);
  }

  /// Gets all upcoming `Bill`s, including ones due today.
  List<Bill> getUpcomingBills() {
    var miliNow = DateTime.now().millisecondsSinceEpoch;
    var miliExtended = DateTime.now()
        .add(Duration(days: _upcomingBillPeriod))
        .millisecondsSinceEpoch;
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

  /// Gets all overdue `Bill`s.
  List<Bill> getOverdueBills() {
    DateTime now = DateTime.now();
    var list = _bills
        .where((bill) =>
            (bill.dueOn.millisecondsSinceEpoch < now.millisecondsSinceEpoch) &&
            !utilities.sameDate(bill.dueOn, DateTime.now()) &&
            (!bill.paid))
        .toList();
    list.sort((a, b) => a.dueOn.millisecondsSinceEpoch
        .compareTo(b.dueOn.millisecondsSinceEpoch));
    return list;
  }

  /// Gets all unpaid `Bill`s.
  List<Bill> getUnpaidBills() {
    var list = _bills.where((bill) => !bill.paid).toList();
    list.sort((a, b) => a.dueOn.millisecondsSinceEpoch
        .compareTo(b.dueOn.millisecondsSinceEpoch));
    return list;
  }

  /// Gets all paid `Bill`s.
  List<Bill> getPaidBills() {
    var list = _bills.where((bill) => bill.paid).toList();
    list.sort((a, b) => a.dueOn.millisecondsSinceEpoch
        .compareTo(b.dueOn.millisecondsSinceEpoch));
    return list;
  }

  /// Gets all `Bill`s that are due on the specified date.
  List<Bill> getBillsByDate(DateTime date) {
    var list =
        _bills.where((bill) => utilities.sameDate(bill.dueOn, date)).toList();
    return list;
  }

  /// Adds one `Bill` to the database and updates the collection.
  Future<void> addBill(Bill bill) async {
    int billKey;
    await _database.transaction((trans) async {
      billKey = await _billsStore.add(trans, bill.toMap());
    }).then((res) {
      bill.id = billKey;
      _bills.add(bill);
      notifyListeners();
    });
  }

  /// Updates the fields of the given `Bill` in the database
  /// and updates the collection.
  Future<void> updateBill(Bill bill) async {
    var record = _billsStore.record(bill.id);

    await _database.transaction((trans) async {
      await record.update(trans, bill.toMap());
      return await record.getSnapshot(trans);
    }).then((res) async {
      var index = _bills.indexOf(bill);
      var updated = Bill.fromMap(res);

      _bills.removeAt(index);
      _bills.add(updated);
      notifyListeners();
    });
  }

  /// Changes the upcoming bills period of the app.
  void changeUpcomingBillPeriod(int period) {
    _upcomingBillPeriod = period;
    _preferences.setInt("upcomingBillPeriod", period);
    notifyListeners();
  }

  /// Adds multiple `Bill`s to the database and updates the collection.
  void addBills(List<Bill> bills) {
    _bills.addAll(bills);
    notifyListeners();
  }

  /// Sets the value of paid to `true` for the specified `Bill` in the database.
  Future<void> setBillPaid(int billId) async {
    var record = _billsStore.record(billId);

    await _database.transaction((trans) async {
      await record.update(trans, {'paid': 1});
    }).then((res) {
      _bills.firstWhere((b) => b.id == billId).paid = true;
      notifyListeners();
    });
  }

  Future<void> setBillUnpaid(int billId) async {
    var record = _billsStore.record(billId);

    await _database.transaction((trans) async {
      await record.update(trans, {'paid': 0});
    }).then((res) {
      _bills.firstWhere((b) => b.id == billId).paid = false;
      notifyListeners();
    });
  }

  /// Deletes a single `Bill` from the database and updates the collection.
  Future<void> deleteBill(int billId) async {
    var record = _billsStore.record(billId);

    await _database.transaction((trans) async {
      await record.delete(trans);
    }).then((res) {
      _bills.removeWhere((bill) => bill.id == billId);
      notifyListeners();
    });
  }

  /// Deletes multiple `Bill`s from the database and updates the collection.
  void deleteBills(List<int> ids) {
    _bills.removeWhere((bill) => ids.contains(bill.id));
    notifyListeners();
  }

  /// Helper function to call from anywhere in the tree.
  static BillsState of(BuildContext context) =>
      ScopedModel.of<BillsState>(context);
}

import 'package:billsmanager/models/BIll.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sqflite/sqflite.dart';

class BillsState extends Model {
  final Database database;
  List<Bill> _bills;

  BillsState({Key key, @required this.database}) {
    _bills = new List<Bill>();
  }

  initBillsState() async {
    List<Map<String, dynamic>> res = await database.query("bills");
    _bills =
        res.isNotEmpty ? res.map((bill) => Bill.fromMap(bill)).toList() : [];
    return this;
  }

  List<Bill> get bills => _bills;

  // Gets a bill from the collection.
  Bill getBill(int id) {
    return _bills.firstWhere((bill) => bill.id == id);
  }

  List<Bill> getUpcomingBills() {
    var miliNow = DateTime.now().millisecondsSinceEpoch;
    var miliExtended =
        DateTime.now().add(Duration(days: 7)).millisecondsSinceEpoch;
    var list = _bills
        .where((bill) =>
            ((bill.dueOn.millisecondsSinceEpoch >= miliNow) ||
                _dueToday(bill)) &&
            (bill.dueOn.millisecondsSinceEpoch <= miliExtended) &&
            (!bill.paid))
        .toList();
    list.sort((a, b) => a.dueOn.millisecondsSinceEpoch
        .compareTo(b.dueOn.millisecondsSinceEpoch));
    return list;
  }

  List<Bill> getOverdueBills() {
    DateTime now = DateTime.now();
    var list = _bills
        .where((bill) =>
            (bill.dueOn.millisecondsSinceEpoch < now.millisecondsSinceEpoch) &&
            !_dueToday(bill))
        .toList();
    list.sort((a, b) => a.dueOn.millisecondsSinceEpoch
        .compareTo(b.dueOn.millisecondsSinceEpoch));
    return list;
  }

  List<Bill> getUnpaidBills() {
    var list = _bills.where((bill) => !bill.paid).toList();
    list.sort((a, b) => a.dueOn.millisecondsSinceEpoch
        .compareTo(b.dueOn.millisecondsSinceEpoch));
    return list;
  }

  List<Bill> getPaidBills() {
    var list = _bills.where((bill) => bill.paid).toList();
    list.sort((a, b) => a.dueOn.millisecondsSinceEpoch
        .compareTo(b.dueOn.millisecondsSinceEpoch));
    return list;
  }

  // Adds one entry to the bills collection.
  void addBill(Bill bill) async {
    await database.insert("bills", bill.toMap()).then((value) {
      _bills.add(bill);
      notifyListeners();
    });
  }

  // Adds multiple entries to the bills collection.
  void addBills(List<Bill> bills) {
    _bills.addAll(bills);
    notifyListeners();
  }

  // Deletes a single entry from the bills collection.
  void deleteBill(int id) {
    _bills.removeWhere((bill) => bill.id == id);
    notifyListeners();
  }

  // Deletes multiple entries from the bills collection.
  void deleteBills(List<int> ids) {
    _bills.removeWhere((bill) => ids.contains(bill.id));
    notifyListeners();
  }

  bool _dueToday(Bill bill) {
    DateTime now = DateTime.now();
    return (bill.dueOn.year == now.year) &&
        (bill.dueOn.month == now.month) &&
        (bill.dueOn.day == now.day);
  }

  static BillsState of(BuildContext context) =>
      ScopedModel.of<BillsState>(context);
}

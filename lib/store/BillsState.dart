import 'package:billsmanager/models/BIll.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BillsState extends Model {
  //final SharedPreferences preferences;
  List<Bill> _bills;

  BillsState() {
    _bills = new List<Bill>();
  }

  List<Bill> get bills => _bills;

  // Gets a bill from the collection.
  Bill getBill(int id) {
    return _bills.firstWhere((bill) => bill.id == id);
  }

  List<Bill> getUpcomingBills() {
    var miliNow = DateTime.now().millisecondsSinceEpoch;
    var miliAddFive = DateTime.now().add(Duration(days: 5)).millisecondsSinceEpoch;
    return _bills.where((bill) => (bill.dueOn.millisecondsSinceEpoch <= miliAddFive) && (bill.dueOn.millisecondsSinceEpoch >= miliNow) && (!bill.paid)).toList();
  }

  // Adds one entry to the bills collection.
  void addBill(Bill bill) {
    _bills.add(bill);
    notifyListeners();
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

  static BillsState of(BuildContext context) =>
      ScopedModel.of<BillsState>(context);
}

library utilities;

import 'package:billsmanager/models/Payment.dart';

bool sameDate(DateTime first, DateTime second) {
  return (first.year == second.year) &&
      (first.month == second.month) &&
      (first.day == second.day);
}

bool overDue(DateTime dueOn) {
  return dueOn.millisecondsSinceEpoch <
      DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;
}

String billItemDueInSubtitle(DateTime dueOn) {
  Duration daysLeft = dueOn.difference(DateTime.now());
  return "${dueOn.month}/${dueOn.day}/${dueOn.year}  >  In ${daysLeft.inDays} days";
}

double sumPayments(List<Payment> payments) {
  double sum = 0.0;
  payments.forEach((p) => sum += double.parse(p.amountPaid));
  return sum;
}

import 'package:sembast/sembast.dart';

/// Describes the attributes of a bill.
/// 
/// Every bill has a due date and amount that's due. This class is for easily
/// representing a bill in the app.
class Bill {
  int id;
  String billType;
  String title;
  DateTime dueOn;
  String amountDue;
  bool reminder;
  String reminderPeriod;
  bool repeats;
  String repeatPeriod;
  String notes;
  bool paid;

  Bill();

  Bill.withValues(
      this.id,
      this.billType,
      this.title,
      this.dueOn,
      this.amountDue,
      this.reminder,
      this.reminderPeriod,
      this.repeats,
      this.repeatPeriod,
      this.notes,
      this.paid);

  /// Converts `Bill` object into a `Map<String, dynamic>` for writing to the
  /// database.
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "bill_type": billType,
      "title": title,
      "due_on": dueOn.millisecondsSinceEpoch,
      "amount_due": amountDue,
      "reminder": reminder == true ? 1 : 0,
      "reminder_period": reminderPeriod,
      "repeats": repeats == true ? 1 : 0,
      "repeat_period": repeatPeriod,
      "notes": notes,
      "paid": paid == true ? 1 : 0
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  /// Converts database read results into a `Bill` object.
  Bill.fromMap(RecordSnapshot<int, Map<String, dynamic>> snapshot) {
    var fields = snapshot.value;

    id = snapshot.key;
    billType = fields["bill_type"];
    title = fields["title"];
    dueOn = DateTime.fromMillisecondsSinceEpoch(fields["due_on"]);
    amountDue = fields["amount_due"];
    reminder = fields["reminder"] == 1;
    reminderPeriod = fields["reminder_period"];
    repeats = fields["repeats"] == 1;
    repeatPeriod = fields["repeat_period"];
    notes = fields["notes"];
    paid = fields["paid"] == 1;
  }
}

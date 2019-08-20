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
      this.notes);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "bill_type": billType,
      "title": title,
      "due_on": dueOn.millisecondsSinceEpoch,
      "amount_due": amountDue,
      "reminder_period": reminderPeriod,
      "repeats": repeats == true ? 1 : 0,
      "repeat_period": repeatPeriod,
      "notes": notes,
      "paid": paid == true ? 1 : 0
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }

  Bill.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    billType = map["bill_type"];
    title = map["title"];
    dueOn = DateTime.fromMillisecondsSinceEpoch(map["due_on"]);
    amountDue = map["amount_due"];
    reminderPeriod = map["reminder_period"];
    repeats = map["repeats"] == 1;
    repeatPeriod = map["repeat_period"];
    notes = map["notes"];
    paid = map["paid"] == 1;
  }
}

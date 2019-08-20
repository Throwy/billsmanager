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
}

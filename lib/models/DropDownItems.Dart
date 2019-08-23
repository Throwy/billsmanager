/// Helper class to store items that belong in drop down lists.
class DropDownItems {
  /// Holds all of the different bill types.
  static final List<String> billTypes = [
    "Car Loan",
    "Credit Card",
    "Education",
    "Utilities",
    "Entertainment",
    "Events",
    "Mortgage",
    "Rent",
    "Insurance",
    "Internet",
    "Phone",
  ];

  /// Holds all of the different reminder periods.
  static final List<String> reminderPeriods = [
    "No Reminder",
    "1 day before",
    "2 days before",
    "3 days before",
    "4 days before",
    "5 days before",
  ];

  /// Holds all of the different repeat periods.
  static final List<String> repeatPeriods = [
    "Does not repeat",
    "Daily",
    "Weekly",
    "Bi-weekly",
    "Monthly",
    "Bi-monthly",
    "Annually",
  ];
}

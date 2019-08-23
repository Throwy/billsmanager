class Payment {
  int id;
  int billId;
  String amountPaid;
  DateTime paidOn;

  Payment();

  Payment.withValues(this.id, this.billId, this.amountPaid, this.paidOn);

  /// Converts [Payment] object into a [Map<String, dynamic>] for writing to the
  /// database.
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "bill_id": billId,
      "amount_paid": amountPaid,
      "paid_on": paidOn.millisecondsSinceEpoch
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  /// Converts database read results into a [Payment] object.
  Payment.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    billId = map["bill_id"];
    amountPaid = map["amount_paid"];
    paidOn = DateTime.fromMillisecondsSinceEpoch(map["paid_on"]);
  }
}

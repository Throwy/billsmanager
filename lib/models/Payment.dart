class Payment {
  int id;
  int billId;
  String amountPaid;

  Payment();

  Payment.withValues(
    this.id,
    this.billId,
    this.amountPaid
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "bill_id": billId,
      "amount_paid": amountPaid
    };
    if(id != null) {
      map["id"] = id;
    }
    return map;
  }

  Payment.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    billId = map["bill_id"];
    amountPaid = map["amount_paid"];
  }
}
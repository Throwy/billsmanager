import 'package:sembast/sembast.dart';

/// Describes the attributes of a payment.
///
/// Every payment must be associated with a [Bill] with the property [billId];
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
  Payment.fromMap(RecordSnapshot<int, Map<String, dynamic>> snapshot) {
    var fields = snapshot.value;

    id = snapshot.key;
    billId = fields["bill_id"];
    amountPaid = fields["amount_paid"];
    paidOn = DateTime.fromMillisecondsSinceEpoch(fields["paid_on"]);
  }
}

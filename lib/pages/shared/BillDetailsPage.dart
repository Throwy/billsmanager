import 'package:billsmanager/helpers/utilities.dart' as utilities;
import 'package:billsmanager/models/Bill.dart';
import 'package:billsmanager/models/Payment.dart';
import 'package:billsmanager/pages/entryforms/BillFormPage.dart';
import 'package:billsmanager/store/AppState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_alert/flutter_alert_material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

class BillDetailsPage extends StatefulWidget {
  final Bill bill;

  const BillDetailsPage({Key key, @required this.bill}) : super(key: key);

  BillDetailsPageState createState() => new BillDetailsPageState();
}

class BillDetailsPageState extends State<BillDetailsPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  double _amountLeft;
  double _paymentsSum;
  String _paymentAmount;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppState>(
      builder: (context, child, model) {
        List<Payment> payments =
            model.paymentsState.getPaymentsByBill(widget.bill.id);
        _paymentsSum = utilities.sumPayments(payments);

        return Scaffold(
          appBar: AppBar(
            title: Text("Details"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return BillFormPage(
                        title: "Edit Bill",
                        bill: widget.bill,
                      );
                    },
                  ));
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showMaterialAlert(
                    context: context,
                    barrierDismissible: true,
                    title: "Delete bill?",
                    body: "This will delete any payments associated with it.",
                    actions: [
                      AlertAction(
                        text: "CANCEL",
                        onPressed: () {},
                        automaticallyPopNavigation: true,
                      ),
                      AlertAction(
                        text: "DELETE",
                        onPressed: () {
                          ScopedModel.of<AppState>(context)
                              .paymentsState
                              .deletePaymentsForBill(widget.bill.id)
                              .then((value) {
                            ScopedModel.of<AppState>(context)
                                .billsState
                                .deleteBill(widget.bill.id);
                          }).then((res) {
                            Navigator.of(context).pop();
                          });
                        },
                        automaticallyPopNavigation: true,
                        isDestructiveAction: true,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildHeader(),
                Divider(),
                !widget.bill.paid
                    ? _buildDueRow(_paymentsSum)
                    : _buildPaidRow(),
                Divider(),
                Expanded(
                  flex: 1,
                  child: _buildNotesSection(),
                ),
                Divider(),
                _buildMakePaymentRow(),
                Expanded(
                  flex: 3,
                  child: _buildPaymentsColumn(payments),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      child: ListTile(
        title: Text(
          widget.bill.title,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.bill.billType,
          style: TextStyle(),
        ),
        trailing: Text(NumberFormat.simpleCurrency()
            .format(double.parse(widget.bill.amountDue))),
      ),
    );
  }

  Widget _buildDueRow(double paymentsSum) {
    String dueOn = DateFormat.yMMMMd().format(widget.bill.dueOn);
    bool overDue = utilities.overDue(widget.bill.dueOn);
    bool sameDate = utilities.sameDate(widget.bill.dueOn, DateTime.now());

    _amountLeft = double.parse(widget.bill.amountDue) - paymentsSum;

    String top = widget.bill.dueOn.difference(DateTime.now()).inDays.toString();
    String bottom = "Days to Pay";
    TextStyle style = TextStyle(color: Theme.of(context).textTheme.body1.color);
    if (sameDate) {
      top = "Due Today";
      bottom = "Pay Now";
    } else if (overDue) {
      top = DateTime.now().difference(widget.bill.dueOn).inDays.toString();
      bottom = "Days past";
      style = TextStyle(color: Colors.red[400]);
    }

    return Container(
      child: ListTile(
        title: Text(NumberFormat.simpleCurrency().format(_amountLeft)),
        subtitle: Text("By $dueOn"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              top,
              style: style,
            ),
            Text(
              bottom,
              style: style,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaidRow() {
    return Container(
      child: ListTile(
        title: Text(NumberFormat.simpleCurrency()
            .format(double.parse(widget.bill.amountDue))),
        subtitle: Text("Paid"),
        trailing: Icon(Icons.check_circle),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(widget.bill.notes),
          ),
        ],
      ),
    );
  }

  Widget _buildMakePaymentRow() {
    if (!widget.bill.paid) {
      return Container(
        child: ListTile(
          title: Text("Make a payment"),
          trailing: IconButton(
            icon: Icon(Icons.add_circle),
            color: Theme.of(context).accentColor,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return _buildPaymentDialog();
                  });
            },
          ),
        ),
      );
    } else {
      return Container(
        child: ListTile(
          title: Text("History"),
        ),
      );
    }
  }

  Widget _buildPaymentsColumn(List<Payment> payments) {
    return Container(
      child: Scrollbar(
        child: ListView(
            children: payments
                .map(
                  (p) => Slidable(
                    key: ValueKey(p.id.toString()),
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                      title: Text(NumberFormat.simpleCurrency()
                          .format(double.parse(p.amountPaid))),
                      trailing: Text(
                        DateFormat.yMd().format(p.paidOn),
                      ),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          showMaterialAlert(
                            context: context,
                            barrierDismissible: true,
                            title:
                                "Delete payment of ${NumberFormat.simpleCurrency().format(double.parse(p.amountPaid))}?",
                            actions: [
                              AlertAction(
                                text: "CANCEL",
                                onPressed: () {},
                                automaticallyPopNavigation: true,
                              ),
                              AlertAction(
                                text: "DELETE",
                                onPressed: () {
                                  ScopedModel.of<AppState>(context)
                                      .paymentsState
                                      .deletePayment(p.id)
                                      .then((res) {
                                    if (_paymentsSum -
                                            double.parse(p.amountPaid) <
                                        double.parse(widget.bill.amountDue)) {
                                      ScopedModel.of<AppState>(context)
                                          .billsState
                                          .setBillUnpaid(widget.bill.id);
                                    }
                                  });
                                },
                                automaticallyPopNavigation: true,
                                isDestructiveAction: true,
                              ),
                            ],
                          );
                        },
                      )
                    ],
                    closeOnScroll: true,
                  ),
                )
                .toList()),
      ),
    );
  }

  Widget _buildPaymentDialog() {
    return AlertDialog(
      title: Text("Add Payment"),
      content: FormBuilder(
        key: _formKey,
        child: Row(
          children: <Widget>[
            Expanded(
              child: FormBuilderTextField(
                attribute: "paymentAmount",
                autofocus: true,
                keyboardType: TextInputType.number,
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ],
                decoration: InputDecoration(
                  labelText: "Amount",
                  icon: Icon(Icons.attach_money),
                ),
                onChanged: (val) => setState(() {
                  _paymentAmount = val;
                }),
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("CANCEL"),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text("ACCEPT"),
          onPressed: () {
            ScopedModel.of<AppState>(context)
                .paymentsState
                .addPayment(Payment.withValues(
                  null,
                  widget.bill.id,
                  _paymentAmount,
                  DateTime.now(),
                ))
                .then((res) {
              var total = _paymentsSum + double.parse(_paymentAmount);
              if (total >= double.parse(widget.bill.amountDue)) {
                ScopedModel.of<AppState>(context)
                    .billsState
                    .setBillPaid(widget.bill.id);
              }
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

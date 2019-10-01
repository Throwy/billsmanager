import 'package:billsmanager/models/Bill.dart';
import 'package:billsmanager/store/AppState.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:billsmanager/models/DropDownItems.Dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:scoped_model/scoped_model.dart';

class BillFormPage extends StatefulWidget {
  final String title;
  final Bill bill;

  const BillFormPage({
    Key key,
    @required this.title,
    this.bill,
  }) : super(key: key);

  BillFormPageState createState() => new BillFormPageState();
}

class BillFormPageState extends State<BillFormPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  Bill _billToEdit;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    if (widget.bill != null) {
      _billToEdit = widget.bill;
      _editing = true;
    } else {
      _billToEdit = new Bill();
      _billToEdit.paid = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                if (_editing) {
                  ScopedModel.of<AppState>(context)
                      .billsState
                      .updateBill(_billToEdit);
                } else {
                  ScopedModel.of<AppState>(context)
                      .billsState
                      .addBill(_billToEdit);
                }
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          FormBuilder(
            key: _formKey,
            child: Column(
              children: <Widget>[
                FormBuilderDropdown(
                  attribute: "billType",
                  initialValue: _billToEdit.billType,
                  decoration: InputDecoration(
                    labelText: "Bill Type",
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  hint: Text("Select Bill Type"),
                  items: DropDownItems.billTypes
                      .map(
                        (type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() {
                    _billToEdit.billType = val;
                  }),
                ),
                FormBuilderTextField(
                  attribute: "title",
                  initialValue: _billToEdit.title,
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(30),
                  ],
                  onChanged: (val) => setState(() {
                    _billToEdit.title = val;
                  }),
                ),
                FormBuilderTextField(
                  attribute: "amountDue",
                  initialValue: _billToEdit.amountDue,
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Amount Due",
                  ),
                  onChanged: (val) => setState(() {
                    _billToEdit.amountDue = val;
                  }),
                ),
                FormBuilderDateTimePicker(
                  attribute: "dueOn",
                  initialValue: _billToEdit.dueOn,
                  inputType: InputType.date,
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  format: DateFormat("yMd"),
                  decoration: InputDecoration(
                    labelText: "Due On",
                  ),
                  onChanged: (val) => setState(() {
                    _billToEdit.dueOn = val;
                  }),
                ),
                FormBuilderDropdown(
                  attribute: "reminderPeriod",
                  initialValue: _billToEdit.reminderPeriod,
                  hint: Text("Select Reminder Period"),
                  decoration: InputDecoration(
                    labelText: "Reminder",
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  items: DropDownItems.reminderPeriods
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() {
                    _billToEdit.reminder = val == "No Reminder" ? false : true;
                    _billToEdit.reminderPeriod = val;
                  }),
                ),
                FormBuilderDropdown(
                  attribute: "repeatPeriod",
                  initialValue: _billToEdit.repeatPeriod,
                  hint: Text("Select repeat period"),
                  decoration: InputDecoration(
                    labelText: "Repeat",
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  items: DropDownItems.repeatPeriods
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() {
                    _billToEdit.repeats =
                        val == "Does not repeat" ? false : true;
                    _billToEdit.repeatPeriod = val;
                  }),
                ),
                FormBuilderTextField(
                  attribute: "notes",
                  initialValue: _billToEdit.notes,
                  decoration: InputDecoration(
                    labelText: "Notes",
                  ),
                  maxLines: 4,
                  onChanged: (val) => setState(() {
                    _billToEdit.notes = val;
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

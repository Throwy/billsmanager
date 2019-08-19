import 'package:billsmanager/models/BIll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:billsmanager/models/DropDownItems.Dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreateBillPage extends StatefulWidget {
  CreateBillPageState createState() => new CreateBillPageState();
}

class CreateBillPageState extends State<CreateBillPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final String _title = "Add Bill";
  Bill _newBill = new Bill();

  @override
  void initState() {
    super.initState();
  }

  void createBill() {
    if (_formKey.currentState.validate()) {
      print(_newBill.billType);
      print(_newBill.title);
      print(_newBill.amountDue);
      print(_newBill.dueOn);
      print(_newBill.reminderPeriod);
      print(_newBill.repeatPeriod);
      print(_newBill.notes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              createBill();
              Navigator.pop(context);
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
                    _newBill.billType = val;
                  }),
                ),
                FormBuilderTextField(
                  attribute: "title",
                  decoration: InputDecoration(
                    labelText: "Title",
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(30),
                  ],
                  onChanged: (val) => setState(() {
                    _newBill.title = val;
                  }),
                ),
                FormBuilderTextField(
                  attribute: "amountDue",
                  validators: [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.numeric(),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Amount Due",
                  ),
                  onChanged: (val) => setState(() {
                    _newBill.amountDue = val;
                  }),
                ),
                FormBuilderDateTimePicker(
                  attribute: "dueOn",
                  inputType: InputType.date,
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  format: DateFormat("MM-dd-yyyy"),
                  decoration: InputDecoration(
                    labelText: "Due On",
                  ),
                  onChanged: (val) => setState(() {
                    _newBill.dueOn = val;
                  }),
                ),
                FormBuilderDropdown(
                  attribute: "reminderPeriod",
                  hint: Text("Select Reminder Period"),
                  decoration: InputDecoration(
                    labelText: "Reminder",
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  //initialValue: "5 days before",
                  items: DropDownItems.reminderPeriods
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() {
                    _newBill.reminderPeriod = val;
                  }),
                ),
                FormBuilderDropdown(
                  attribute: "repeatPeriod",
                  hint: Text("Select repeat period"),
                  decoration: InputDecoration(
                    labelText: "Repeat",
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  //initialValue: "Does not repeat",
                  items: DropDownItems.repeatPeriods
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() {
                    _newBill.repeatPeriod = val;
                  }),
                ),
                FormBuilderTextField(
                  attribute: "notes",
                  decoration: InputDecoration(
                    labelText: "Notes",
                  ),
                  maxLines: 4,
                  onChanged: (val) => setState(() {
                    _newBill.notes = val;
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

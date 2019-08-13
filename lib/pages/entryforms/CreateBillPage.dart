import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:billsmanager/models/DropDownItems.Dart';

class CreateBillPage extends StatefulWidget {
  CreateBillPageState createState() => new CreateBillPageState();
}

class CreateBillPageState extends State<CreateBillPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final String _title = "Add Bill";

  EdgeInsets _fieldMargins = EdgeInsets.fromLTRB(0, 0.0, 0, 0.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => print("Create"),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: _fieldMargins,
                  child: FormField(
                    builder: (context) {
                      return DropdownButton(
                        isExpanded: true,
                        onChanged: (value) => print(value),
                        items: DropDownItems.billTypes.map<DropdownMenuItem>(
                          (type) {
                            return DropdownMenuItem(
                              child: Text(type),
                            );
                          },
                        ).toList(),
                      );
                    },
                  ),
                ),
                Container(
                  margin: _fieldMargins,
                  child: FormField(
                    builder: (context) {
                      return TextField(
                        decoration: InputDecoration(
                          hintText: "Title",
                          border: InputBorder.none
                        ),
                      );
                    },
                  ),
                ),
                Divider(
                  color: Theme.of(context).accentColor,
                ),
                Container(
                  margin: _fieldMargins,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Amount",
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                  ),
                ),
                Container(
                  margin: _fieldMargins,
                  child: TextField(
                    readOnly: true,
                    onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year),
                      lastDate: DateTime(2999),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.dark(),
                          child: child,
                        );
                      },
                    ),
                    decoration: InputDecoration(
                      hintText: "Due Date",
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:billsmanager/store/AppState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class BillsSettingsPage extends StatelessWidget {
  final TextStyle _headerStyle = new TextStyle().copyWith(fontSize: 20.0);

  List<DropdownMenuItem> _getPeriodOptions() {
    List<DropdownMenuItem> list = new List<DropdownMenuItem>();
    for (int i = 0; i <= 15; i++) {
      list.add(DropdownMenuItem(
        child: Text(i.toString()),
        value: i,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bills"),
      ),
      body: ScopedModelDescendant<AppState>(
        builder: (context, child, model) {
          return ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "Upcoming Bills Period",
                      style: _headerStyle,
                    ),
                    subtitle: Text(
                        "Set how many days the app looks ahead for upcoming bills."),
                    trailing: DropdownButton(
                      value: model.billsState.upcomingBillPeriod,
                      items: _getPeriodOptions(),
                      onChanged: (val) {
                        model.billsState.changeUpcomingBillPeriod(val);
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

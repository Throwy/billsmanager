import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class CalendarPage extends StatefulWidget {
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calendar"),
        ),
        body: Container(
          child: CalendarCarousel(
            daysHaveCircularBorder: null,
            onDayPressed: (DateTime date, list) =>
                setState(() => _selectedDate = date),
            todayButtonColor: Theme.of(context).accentColor,
            todayTextStyle: TextStyle(
              color: Theme.of(context).accentTextTheme.body1.color,
            ),
            daysTextStyle: TextStyle(
              color: Theme.of(context).textTheme.body1.color,
            ),
            weekendTextStyle: TextStyle(
              color: Theme.of(context).accentColor,
            ),
            weekdayTextStyle: TextStyle(
              color: Theme.of(context).accentColor,
            ),
            headerTextStyle: TextStyle(
                color: Theme.of(context).textTheme.body1.color, fontSize: 20.0),
            iconColor: Theme.of(context).textTheme.body1.color,
          ),
        ));
  }
}

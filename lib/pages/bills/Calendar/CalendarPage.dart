import 'package:billsmanager/helpers/Events/EventList.dart';
import 'package:billsmanager/pages/shared/BillDetailsPage.dart';
import 'package:billsmanager/store/AppState.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  DateTime _selectedDate;
  EventList _events;
  List _selectedEvents;
  CalendarController _calendarController;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _events = new EventList();
    _selectedDate = DateTime.now();
    ScopedModel.of<AppState>(context).billsState.bills.forEach((bill) {
      _events.add(bill.dueOn, bill);
    });

    _selectedEvents = _events.getEvents(_selectedDate);

    _calendarController = new CalendarController();
    _animationController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.today,
            ),
            onPressed: () {
              _calendarController.setSelectedDay(
                DateTime.now(),
                runCallback: true,
              );
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildTableCalendar(),
          SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      initialSelectedDay: DateTime.now(),
      events: _events.events,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.horizontalSwipe,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle:
            TextStyle().copyWith(color: Theme.of(context).accentColor),
      ),
      calendarStyle: CalendarStyle(
        selectedColor: Theme.of(context).accentColor,
        selectedStyle: TextStyle()
            .copyWith(color: Theme.of(context).accentTextTheme.body1.color),
        todayColor: Theme.of(context).primaryColor,
        todayStyle: TextStyle()
            .copyWith(color: Theme.of(context).textTheme.body1.color),
        weekendStyle:
            TextStyle().copyWith(color: Theme.of(context).accentColor),
        outsideWeekendStyle: TextStyle().copyWith(color: Colors.grey),
      ),
      headerStyle: HeaderStyle(
        formatButtonShowsNext: false,
        formatButtonTextStyle: TextStyle().copyWith(
            color: Theme.of(context).accentTextTheme.body1.color,
            fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: Theme.of(context).textTheme.body1.color,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: Theme.of(context).textTheme.body1.color,
        ),
      ),
      onDaySelected: _onDaySelected,
      builders:
          CalendarBuilders(markersBuilder: (context, date, events, holidays) {
        final children = <Widget>[];

        if (events.isNotEmpty) {
          children.add(
            Positioned(
              bottom: 1,
              child: _buildEventsMarker(date, events),
            ),
          );
        }
        return children;
      }),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Theme.of(context).primaryColorDark),
      width: 14.0,
      height: 14.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 11.0,
          ),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map(
            (b) => Container(
              padding: EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BillDetailsPage(
                          bill: b,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: ListTile(
                      title: Text(b.title),
                      trailing: Text(NumberFormat.simpleCurrency()
                          .format(double.parse(b.amountDue))),
                      subtitle: Text(b.billType),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

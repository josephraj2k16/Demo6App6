import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:MediAssist/Devefy/ProductCard.dart';

//
//void main() => runApp(MaterialApp(
//      home: calendrExam(),
//      debugShowCheckedModeBanner: false,
//    ));

class calendrExam extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return cale();
  }

}
class cale extends State<calendrExam>with TickerProviderStateMixin{
  var datesList = [];
  var _stateDate = DateTime.now();
  Map<DateTime, List> _visibleEvents;
  Map<DateTime, List> _visibleHolidays;
  AnimationController _controller;
  @override
  void initState() {

    super.initState();
    for (int i = -14; i < 57; i++) {
      DateTime date = _stateDate;
      date = date.add(Duration(days: i));
      datesList.add(date);
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      );

      _controller.forward();
    }
  }
  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Utils.isSameDay(date, _stateDate)
            ? Colors.brown[500]
            : Utils.isSameDay(date, DateTime.now()) ? Colors.brown[300] : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }
//  void _onDaySelected(DateTime day, List events) {
//    setState(() {
//      _selectedDay = day;
//      _selectedEvents1 = events;
//      //_card = events;
//
//
//    });
//  }
//
//  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
//    setState(() {
//      _visibleEvents = Map.fromEntries(
//        _events2.entries.where(//_events1.entries
//              (entry) =>
//          entry.key.isAfter(first.subtract(const Duration(days: 1))) &&
//              entry.key.isBefore(last.add(const Duration(days: 1))),
//        ),
//      );
//
//      _visibleHolidays = Map.fromEntries(
//        _holidays.entries.where(
//              (entry) =>
//          entry.key.isAfter(first.subtract(const Duration(days: 1))) &&
//              entry.key.isBefore(last.add(const Duration(days: 1))),
//        ),
//      );
//    });
//  }
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'en_US',
      events: _visibleEvents,
      holidays: _visibleHolidays,
      initialCalendarFormat: CalendarFormat.week,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.week: '',
        // CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_controller),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.green[400],//deepOrange[300]
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.lightGreen[300],//amber[400]
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }
          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events) {
        //_onDaySelected(date, events);
        _controller.forward(from: 0.0);
      },
      //onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Text("hi"),
        //TabBar(
//              tabs: <Widget>[
//                _buildTabs(),
//              ],
//              isScrollable: true,
//            ),
          ),
        body: _buildSchedule(),

    );
  }


  @override
  Widget _buildSchedule() {
    return Container(
      child: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('Prescription')
                .where('mrn', isEqualTo: 1001)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading...');
              }
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    _buildScheduleItem(context, snapshot.data.documents[index]),
              );
            }),
      ),
    );


  }
  Widget _buildScheduleItem(BuildContext cot,DocumentSnapshot sn){
    //return Text("One"+sn["mrn"].toString());

    return ProductCard(0xFFccff66, sn["image_url"],
        sn["drug_name"],
        sn["sig_info"],//snapshot[index].data["sig_info"]
        sn["refills_left"].toString(),
        "8:38AM");
  }

}

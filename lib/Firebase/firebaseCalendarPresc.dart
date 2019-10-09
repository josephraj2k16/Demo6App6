

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:MediAssist/Devefy/ProductCard.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2019, 1, 1): ['New Year\'s Day'],
  DateTime(2019, 1, 6): ['Epiphany'],
  DateTime(2019, 2, 14): ['Valentine\'s Day'],
  DateTime(2019, 4, 21): ['Easter Sunday'],
  DateTime(2019, 4, 22): ['Easter Monday'],
};




class MyAppCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Prescription Calendar',
      theme: ThemeData(
        primarySwatch: Colors.lightGreenAccent[300],
      ),
      home: firebaseCalendarPresc(title: 'Your Prescription Calendar'),
    );
  }
}

class firebaseCalendarPresc extends StatefulWidget {
  firebaseCalendarPresc({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<firebaseCalendarPresc> with TickerProviderStateMixin {
  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot> snapshot;
  List<DocumentSnapshot> snapshot1;

  CollectionReference collectionReference =Firestore.instance.collection("Prescription");

  DateTime _selectedDay;
  Map<DateTime, List> _events;
  Map<DateTime, List> _cardview;
  Map<DateTime, List> _visibleEvents;
  Map<DateTime, List> _visibleHolidays;
  Map<DateTime,Widget> _visibleCards;
  List _selectedEvents;
  List _selectedEvents1;
  List<Widget> _card;
  Map<DateTime, List> _events1;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    var x=  collectionReference
        .where("mrn",isEqualTo: 1001).snapshots();
    x.listen((onData){
      setState(() {
        snapshot1 = onData.documents;

      });

    });

    _selectedDay = DateTime.now();
    _cardview = {
      _selectedDay.add(Duration(days: 3)): [ProductCard(0xFFccff66, "assets/tab3.jpg",
          "Mupirocin Ointment", "Use this medication only on skin.Apply three times a day,You may cover the treated area with bandage", "3",
          "8:38AM")],
    };
    _events = {
      _selectedDay.subtract(Duration(days: 30)): ['Event A0', 'Event B0', 'Event C0'],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): ['Event A2', 'Event B2', 'Event C2', 'Event D2'],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): ['Event A4', 'Event B4', 'Event C4'],
      _selectedDay.subtract(Duration(days: 4)): ['Event A5', 'Event B5', 'Event C5'],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): ['Event A8', 'Event B8', 'Event C8', 'Event D8'],
      _selectedDay.add(Duration(days: 3)): Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): ['Event A10', 'Event B10', 'Event C10'],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): ['Event A12', 'Event B12', 'Event C12', 'Event D12'],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): ['Event A14', 'Event B14', 'Event C14'],
    };

    _events1={
      _selectedDay.add(Duration(days: 1)):
        //snapshot1

        [
        ProductCard(0xFFccff66, "assets/tab1.jpg",
          "Mupirocin Ointment", "Use this medication only on skin.Apply three times a day,You may cover the treated area with bandage", "3",
          "8:38AM"),
        ProductCard(0xFFccff66, "assets/tab2.jpg",
            "Paracetamol 500 mg", "Take this tablet by mouth after food", "2","10:14AM")
        ,ProductCard(0xFFccff66, "assets/tab1.jpg",
            "Ascorbic Acid 500 mg", "Take this tablet by mouth after food", "1","12:05PM")
        ,],
//      [
//        ProductCard(0xFFccff66, '${snapshot[0]['image_url']}',
//            '${snapshot[0]['drug_name']}', '${snapshot[0]['sig_info']}', '${snapshot[0]['sig_info']}',
//            "8:38AM")
////        ProductCard(0xFFccff66, "assets/tab2.jpg",
////            "Paracetamol 500 mg", "Take this tablet by mouth after food", "2","10:14AM")
////        ,ProductCard(0xFFccff66, "assets/tab1.jpg",
////          "Ascorbic Acid 500 mg", "Take this tablet by mouth after food", "1","12:05PM")
//        ,],
    };
    _selectedEvents = _events[_selectedDay] ?? [];
    _selectedEvents1 = _events1[_selectedDay] ?? [];



    _card = _cardview[_selectedDay] ?? [];




    _visibleEvents = _events1;
    _visibleHolidays = _holidays;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _controller.forward();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents1 = events;
      //_card = events;


    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
    setState(() {
      _visibleEvents = Map.fromEntries(
        _events1.entries.where(//_events1.entries
              (entry) =>
          entry.key.isAfter(first.subtract(const Duration(days: 1))) &&
              entry.key.isBefore(last.add(const Duration(days: 1))),
        ),
      );

      _visibleHolidays = Map.fromEntries(
        _holidays.entries.where(
              (entry) =>
          entry.key.isAfter(first.subtract(const Duration(days: 1))) &&
              entry.key.isBefore(last.add(const Duration(days: 1))),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          // _buildTableCalendar(),
          _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),//buildEventList()
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'en_US',
      events: _visibleEvents,
      holidays: _visibleHolidays,
      initialCalendarFormat: CalendarFormat.week,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.twoWeeks: '2 weeks',
        CalendarFormat.week: 'Week',
      },
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle: TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
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
        _onDaySelected(date, events);
        _controller.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Utils.isSameDay(date, _selectedDay)
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

  Widget buildEventlist3(){
    new ListView.builder(
        itemCount: snapshot1.length,
        itemBuilder: (context,index) {
          print(snapshot1.length);
          return new Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 25.0, vertical: 10.0),
            child: new Column(
              children: <Widget>[

                ProductCard(0xFFccff66, snapshot1[index].data["image_url"],
                    snapshot1[index].data["drug_name"],
                    snapshot1[index].data["sig_info"],//snapshot[index].data["sig_info"]
                    snapshot1[index].data["refills_left"].toString(),
                    "8:38AM"),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          );

        }
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents1
          .map((event) => Container(

        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: new Column(
          children: <Widget>[
            event,
            SizedBox(
              height: 5.0,
            ),

          ],
        ),
      )








//             Container(
//            decoration: BoxDecoration(
//              border: Border.all(width: 0.8),
//              borderRadius: BorderRadius.circular(12.0),
//            ),
//            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//            child: ListTile(
//              title: Text(event.toString()),
//              onTap: () => print('$event tapped!'),
//            ),
//          )
      )
          .toList(),
    );
  }
  Widget _buildEventList2(){
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



import 'package:MediAssist/Devefy/ProductCard_selectedDay.dart';
import 'package:MediAssist/Screens/Login/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
StreamSubscription<QuerySnapshot> subscription;
StreamSubscription<QuerySnapshot> subscription1;
StreamSubscription<QuerySnapshot> subscription2;

List<DocumentSnapshot> snapshot;
List<DocumentSnapshot> snapshot1;
List<DocumentSnapshot> snapshot3;
List<DocumentSnapshot> snapshot2;

CollectionReference collectionReference =
Firestore.instance.collection("Prescription");
CollectionReference collectionReferencee =
Firestore.instance.collection("Prescriptions");
CollectionReference userInfo = Firestore.instance.collection("User_Info");

class firebaseCalendarPresc extends StatefulWidget {
  firebaseCalendarPresc({Key key, this.auth, this.userId, this.title})
      : super(key: key);

  final String title;
  final String userId;
  final BaseAuth auth;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<firebaseCalendarPresc>
    with TickerProviderStateMixin {
  String _userId = "";
  bool retreat = false;

  String _onLoggedIn() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.email.toString();
      });
    });
    return _userId;
  }

  DateTime _selectedDay;
  Map<DateTime, List> _events;
  Map<DateTime, List> _cardview;
  Map<DateTime, List> _visibleEvents;
  Map<DateTime, List> _visibleHolidays;
  Map<DateTime, Widget> _visibleCards;
  List _selectedEvents;
  List _selectedEvents1;
  List<Widget> _card;
  Map<DateTime, List> _events1;
  Map<DateTime, List> _events2;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();


    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.documents;
      });
    });
    var now = DateTime.now();
    var de1;
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);
    String user = "james.smith@gmail.com";

//      user= _onLoggedIn();
//      print(user);
//      var de = collectionReference.where("email",isEqualTo:"james.smith@gmail.com").snapshots();
//      de.listen((dataSnapshot){
//        setState(() {
//          snapshot1=dataSnapshot.documents;
//        });
//      });
//          .then((onValue){
//        if(onValue.documents.isNotEmpty){
//          de1=onValue.documents[0].data;
//        }
//        String fr=de1["mrn"];
//        //print(fr);
//      });
//
//    subscription1=collectionReference.where("mrn",isEqualTo: "1001")//.where("start_date",isLessThanOrEqualTo: formatted)
//        .snapshots().listen((dataSnapshot){
//        setState(() {
//        snapshot1=dataSnapshot.documents;
//        });
//       });
//    List<Widget> getTextWidgets(List<DocumentSnapshot> snap)
//    {
//      List<Widget> list = new List<Widget>();
//      for(var i = 0; i < snap.length; i++){
//        list.add(new  ProductCard(0xFFccff66,snap[i].data["image_url"],
//            snap[i].data["drug_name"],snap[i].data["sig_info"],snap[i].data["refills_left"].toString(),
//            "8:38AM"
//        ),);
//      }
//      return list;
//    }
//int indexes= snapshot.length;

//    List xs=List.generate(3,  (card) {
//          Text("hi $card");
////      ProductCard(0xFFccff66, snapshot1[card].data["image_url"],
////          snapshot1[card].data["drug_name"],
////          snapshot1[card].data["sig_info"],//snapshot[index].data["sig_info"]
////          snapshot1[card].data["refills_left"].toString(),
////          "8:38AM");
//
//    });

//List.generate(indexes, generator)
    // Firestore.instance.collection("My_Prescriptions").document("pres1")
    //        .collection("User_Info").document("Users");

//    var x = Firestore.instance.collection("Prescription").where("start_date",isEqualTo: )
//      print(x.snapshots().listen((onData)=>{
//      print(snapshot[0].data["mrn"])
//      }));

//    Future<int>  genCards() async{
//      var now = new DateTime.now();
//      var formatter = new DateFormat('yyyy-MM-dd');
//      String formatted = formatter.format(now);
//      //print(formatted);
//
//      var res = Firestore.instance.collection("Prescription").where("start_date",isLessThanOrEqualTo: formatted);
//      var snapsht = await res.getDocuments();
//      var total = snapsht.documents.length;
//
//      return total;
//    }

    //var x = genCards();

    _selectedDay = DateTime.now();
    _cardview = {
      _selectedDay.add(Duration(days: 3)): [
        ProductCard(
            0xFFccff66,
            "assets/tab3.jpg",
            "Mupirocin Ointment",
            "Use this medication only on skin.Apply three times a day,You may cover the treated area with bandage",
            "3",
            "8:38AM")
      ],
    };
    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(Duration(days: 3)):
      Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    }; //xs as Map<DateTime, List>;
    _events2 = {
      _selectedDay.add(Duration(days: 2)):
      //getTextWidgets(snapshot1)
      [
//        ProductCard(0xFFccff66, "assets/tab3.jpg",
//    "Mupirocin Ointment", "Use this medication only on skin.Apply three times a day,You may cover the treated area with bandage", "3",
//    "8:38AM"),
//    ProductCard(0xFFccff66, "assets/tab2.jpg",
//    "Paracetamol 500 mg", "Take this tablet by mouth after food", "2","10:14AM")
//    ,ProductCard(0xFFccff66, "assets/tab1.jpg",
//    "Ascorbic Acid 500 mg", "Take this tablet by mouth after food", "1","12:05PM")
//    ProductCard(0xFFccff66, snapshot1[0].data["image_url"],
//    snapshot1[0].data["drug_name"],
//    snapshot1[0].data["sig_info"],//snapshot[index].data["sig_info"]
//    snapshot1[0].data["refills_left"].toString(),
//    "8:38AM")
      ]
    };

    _events1 = {
      _selectedDay.add(Duration(days: 1)): [
        ProductCard(
            0xFFccff66,
            "assets/tab3.jpg",
            "Mupirocin Ointment",
            "Use this medication only on skin.Apply three times a day,You may cover the treated area with bandage",
            "3",
            "8:38AM"),
        ProductCard(0xFFccff66, "assets/tab2.jpg", "Paracetamol 500 mg",
            "Take this tablet by mouth after food", "2", "10:14AM"),
        ProductCard(0xFFccff66, "assets/tab1.jpg", "Ascorbic Acid 500 mg",
            "Take this tablet by mouth after food", "1", "12:05PM"),
      ],
    };
    _selectedEvents = _events[_selectedDay] ?? [];
    _selectedEvents1 = _events2[_selectedDay] ?? [];
    // _selectedEvents1=snapshot1;

    _card = _cardview[_selectedDay] ?? [];

    _visibleEvents = _events2;
    _visibleHolidays = _holidays;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _controller.forward();
  }

//    genCards() async {
//    var now = new DateTime.now();
//    var formatter = new DateFormat('yyyy-MM-dd');
//    String formatted = formatter.format(now);
//    //print(formatted);
//
//    var res = Firestore.instance.collection("Prescription").where("start_date",isLessThanOrEqualTo: formatted);
//    var snapsht =  await res.getDocuments();
//    var total = snapsht.documents.length;
//
//    return total;
//  }
  /* Widget _passingDate(DateTime day){
    Widget ret;
    setState(() {
    bool retreat = false;
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(day);
    debugPrint("formatted day is "+formatted);
    var de1;
    String fr="";
    //    String user = _onLoggedIn();
    var de =  userInfo.where("email", isEqualTo: "maria.gracia@gmail.com").getDocuments();
    de.then((onValue) {
      if (onValue.documents.isNotEmpty) {
        de1 = onValue.documents[0].data;
      }
      fr = de1["mrn"];
      var f = collectionReference.where("mrn",isEqualTo: fr).snapshots();//.where("start_date",isLessThanOrEqualTo: formatted)
      f.listen((Querysnap){
        snapshot1=Querysnap.documents;
        DateTime der = snapshot1[0].data["start_date"];
        debugPrint("Date from firestore "+formatter.format(der));
        String frmDate= formatter.format(der);
        if(frmDate==formatted){
          debugPrint("Inside if");
          //qScaffold.of(context).showSnackBar(snackBar);
          retreat = true;
         // ret= Expanded(child: _buildEventList());
          ret= Text("Data Available");
        }*//*else{
          debugPrint("Inside else");
          //ret= Text("No data Available");
        }*//*
      });
    });

    });
    return ret;
  }*/
  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedDay = day;
      _selectedEvents1 = events;
    });
    //return retreat;
//    var f = collectionReference.where("start_date",isLessThanOrEqualTo: formatted).snapshots();
//    f.listen((Querysnap){
//
//        snapshot1=Querysnap.documents;
//        setState(() {
//          _selectedDay = day;
//          _selectedEvents1 = events;
//
//      });
//    });
//    setState(() {
//      _selectedDay = day;
//      _selectedEvents1 = events;
//    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    setState(() {
      _visibleEvents = Map.fromEntries(
        _events2.entries.where(
          //_events1.entries
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

  bool onStart(DateTime day) {
    var de1;
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(day);
    //debugPrint("formatted day is "+formatted);
    String fr = "";
    List<dynamic>fr1=["Welcome"];
    String user = _onLoggedIn();//Line Skipped while calling from main.dart
    /*Stream<QuerySnapshot> unreadMessages = Firestore.instance
        .collection("Prescriptions").document("Intakes")//getTitle(widget.title1)
        .collection(formatted).snapshots();//.document(widget.drugId)
    //.collection(widget.stepText)
    unreadMessages.listen((QuerySnapshot data) {
      int unReadMessageLength = data.documents.length;
      debugPrint("Count of Icons::$unReadMessageLength");
    });*/
    var de = userInfo
        .where("email", isEqualTo: user)
        .getDocuments();
    de.then((onValue) {
      if (onValue.documents.isNotEmpty) {
        de1 = onValue.documents[0].data;

      }
      fr = de1["mrn"];
     // fr1= de1["date"];
     // fr1.forEach((f)=>print("List values "+f.toString()));
      //print(fr);
      collectionReferencee.document("Intakes").collection(formatted).where("mrn",isEqualTo: fr)
      .snapshots()
      .listen((dataSnapshot){
        snapshot1 = dataSnapshot.documents;
      });
      if(snapshot1.isNotEmpty) {
        setState(() {
          retreat = true;
        });
      }
      else{
        setState(() {
          retreat = false;

        });
      }



    /*  subscription1 = collectionReference
          .where("mrn",
          isEqualTo:
          fr) //.where("start_date",isLessThanOrEqualTo: formatted)
          .snapshots()
          .listen((dataSnapshot) {
            //dataSnapshot.documents.c
        //setState(() {
        snapshot1 = dataSnapshot.documents;

//        DateTime der = snapshot1[0].data["start_date"];
//        DateTime der1 = snapshot1[0].data["end_date"];
        *//* startDate= formatter.format(der);
          endDate= formatter.format(der1);
          debugPrint("Date from firestore "+startDate);
          debugPrint("Date from firestore "+endDate);*//*

        *//*if(day.isAfter(der) && day.isBefore(der1)) {
          setState(() {
            retreat = true;

          });
        }
        else{
          setState(() {
            retreat = false;

          });
        }*//*
*//*          setState(() {
            if(frmDate==formatted){
            setState(() {
              retreat = true;

            });
              //qScaffold.of(context).showSnackBar(snackBar);



              debugPrint("Inside if :: $retreat");
              // ret= Expanded(child: _buildEventList());
            //  ret=  new Text("Data Available");
            }else{
              setState(() {
                retreat = false;

              });

              debugPrint("Inside else:: $retreat");

             // ret= new  Text("No data Available");
            }

          });*//*



        //}
        //);
      });*/

    });



//    subscription1=collectionReference.where("mrn",isEqualTo: fr)//.where("start_date",isLessThanOrEqualTo: formatted)
//        .snapshots().listen((dataSnapshot){
//      setState(() {
//        snapshot1=dataSnapshot.documents;
//      });
//    });
    return retreat;
  }

//  String getEmail(){
//    String res1 = _onLoggedIn();
//    var rev;
//    String FullName="";
//    var res = Firestore.instance
//        .collection("Prescription")
//        .where("email", isEqualTo: res1);
//         res.snapshots().listen((dataSnapshot){
//      setState(() {
//        snapshot1=dataSnapshot.documents;
//      });
//    });
//    FullName=snapshot1[0].data["driug_name"];//+rev["last_name"]
//
//    return FullName;
////     // print(snapshot[0].data["first_name"]);
////
//  }
  @override
  Widget build(BuildContext context) {
//    String fer=getEmail();
//    print("inside "+fer);
    /* bool one = false;*/
    bool old= onStart(_selectedDay);
    /*var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(_selectedDay);
    debugPrint("old date "+old.toString());
    debugPrint("Formated date "+formatted);
    if(old==formatted) {
      setState(() {
        one = true;
        debugPrint("inside if $one");
      });
    }else {
      setState(() {
        debugPrint("inside else $one");
       one=false;
      });
          }*/
    //debugPrint("Selected Day :$_selectedDay");
    //Widget oe = _passingDate(_selectedDay);
    // print(snapshot1[0].data["drug_name"]);
    //print(snapshot3[0].data["mrn"]);
//   print(snapshot1[0].data["start_date"]);
////
//    var now = new DateTime.now();
//    var formatter = new DateFormat('yyyy-MM-dd');
//    String formatted = formatter.format(now);
//    print(formatted);

    //print(snapshot1.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), //widget.title
      ),
      body:

      Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          // _buildTableCalendar(),
          _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          old?Expanded(child: _buildEventList()):Center(
              child:Column(
                children: <Widget>[
                  SizedBox(height: 140.0),
                  Text("No Medications on this day",style:TextStyle(fontSize: 18.0,fontFamily: 'Helvetica')),

                ],
              )

          )
          // oe,
          //_passingDate(_selectedDay),

          //Center(child: new Text("No Data Available"))
          //Expanded(child: _buildEventList()),
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
        formatButtonTextStyle:
        TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
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
              color: Colors.green[400],
              //deepOrange[300]
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
            color: Colors.lightGreen[300],
            //amber[400]
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
        //debugPrint("the Day tapped is : $date");
        _onDaySelected(date, events);
        // neon?Expanded(child: _buildEventList()):Center(child: new Text("No data Available"),);
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
            : Utils.isSameDay(date, DateTime.now())
            ? Colors.brown[300]
            : Colors.blue[400],
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

//
//  Widget _pract(){
//    return StreamBuilder(
//      itemCount: snapshot1.length,
//      itemBuilder: (BuildContext c,),
//
//    )
//  }
  _buildScheduleItem(BuildContext c, DocumentSnapshot sn) {
    // AsyncSnapshot<QuerySnapshot>

//    return sn.data.documents
//        .map((doc) => {new ProductCard(0xFFccff66,doc["image_url"],doc["drug_name"],doc["sig_info"]
//        ,doc["refills_left"].toString(),"8:38AM"),
//    })
//        .toList();
    return Container(
      child: Column(
        children:<Widget>[
          ProductCard_selectedDay(
              0xFFccff66,
              sn["image_url"],
              sn["drug_name"],
              sn["sig_info"], //snapshot[index].data["sig_info"]
              sn["refills_left"].toString(),
              _selectedDay,sn["drug_id"],
              sn["schedule"],
              sn["intake"],),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildEventList() {
    return ListView.builder(
      itemCount: snapshot1.length,
      itemBuilder: (BuildContext context, int index) =>
      _buildScheduleItem(context, snapshot1[index]),
    );
//    return new StreamBuilder<QuerySnapshot>(
//        stream: Firestore.instance.collection("Prescription").where("mrn",isEqualTo:1001).snapshots(),
//        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (!snapshot.hasData) return new Text("There is no expense");
//          return new ListView(children: _buildScheduleItem(context,snapshot));
//        });
    // print("before if--");
    /* if (snapshot1.length == null) {
      return Text("No Data");
    } else {
      return ListView.builder(
        itemCount: snapshot1.length,
        itemBuilder: (BuildContext context, int index) =>
            //(index)==0?new Text("No Data"):
            _buildScheduleItem(context, snapshot1[index]),
      );
    }*/
//    return ListView(
//      children: _selectedEvents1
//          .map((event) =>
//          Container(
//             padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
//              child: new Column(
//               children: <Widget>[
//            event,
//                SizedBox(
//              height: 5.0,
//                   ),
//
//                  ],
//               ),
//      )
////             Container(
////            decoration: BoxDecoration(
////              border: Border.all(width: 0.8),
////              borderRadius: BorderRadius.circular(12.0),
////            ),
////            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
////            child: ListTile(
////              title: Text(event.toString()),
////              onTap: () => print('$event tapped!'),
////            ),
////          )
//      ).toList(),
//    );
  }
}


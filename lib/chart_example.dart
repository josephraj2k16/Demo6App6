/*
import 'package:MediAssist/fchart_sample.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//void main() => runApp(new FChartsExampleApp());

class ChartExample {
  ChartExample(this.widget, this.description, this.description1);

  final Widget widget;
  final String description;
  final String description1;
}

final charts = [
  new ChartExample(
    new fchart_dimple(),

    'Bimatoprost',
    'X-Axis indicates Date,Y-Axis indicates number of intakes',
  ),
  new ChartExample(
    new fchart_dimple(),
    'Bimatoprost',
    'X-Axis indicates Date,Y-Axis indicates number of intakes',
  ),
];

class FChartsExampleApp extends StatefulWidget {
  FChartsExampleApp(this.mrn);

  String mrn;

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<FChartsExampleApp> {
  var _chartIndex = 0;
  List<DocumentSnapshot> snapshot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> dates = [
      "2019-05-14",
      "2019-05-15",
      "2019-05-16",
    ];
    dates.forEach((date) {
      Firestore.instance
          .collection("Prescriptions")
          .document("Intakes")
          .collection(date)
          .where("mrn", isEqualTo: widget.mrn)
          .getDocuments()
          .then((data) {
        snapshot = data.documents;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Medication Adherence'),
        ),
        body: new Container(
          */
/* decoration: new BoxDecoration(
            color: Colors.white,
          ),*/
/*

          child: _newEventList(),
        ),
      ),
    );
  }

  Widget _newEventList() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection("Prescriptions")
          .document("Intakes")
          .collection("2019-05-14")
          .where("mrn", isEqualTo: widget.mrn)
          .snapshots(),
      */
/*itemCount: snapshot.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildGraphItem(context, snapshot[index]),*/
/*

      builder: (context, snapShot) {
        _buildGraphItem(context,snapShot);
      },
    );
  }

  _widgets(BuildContext c, QuerySnapshot d) {
    List<Widget> widgets = [];
    final chart = charts[_chartIndex % charts.length];
    widgets.add(new Column(
      children: [
        new Padding(
          padding: new EdgeInsets.all(30.0),
          child: new Text(
            chart.description,
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
        new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Container(
            child: chart.widget,
          ),
        ),
        new Padding(
          padding: new EdgeInsets.all(30.0),
          child: new Text(
            chart.description1,
//style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));
  }

  _buildGraphItem(BuildContext c, AsyncSnapshot sn) {
    final chart = charts[_chartIndex % charts.length];
    return Column(
      children: [
        new Padding(
          padding: new EdgeInsets.all(30.0),
          child: new Text(
            chart.description,
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
        new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Container(
            child: chart.widget,
          ),
        ),
        new Padding(
          padding: new EdgeInsets.all(30.0),
          child: new Text(
            chart.description1,
//style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
*/
import 'package:MediAssist/fchart_sample.dart';
import 'package:flutter/material.dart';

//void main() => runApp(new FChartsExampleApp());

class ChartExample {
  ChartExample(

      this.widget,
      this.description,
      this.description1
      );


  final Widget widget;
  final String description;
  final String description1;
}

final charts = [

];

class FChartsExampleApp extends StatefulWidget {
  FChartsExampleApp(this.mrn);
  String mrn;
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<FChartsExampleApp> {
  var _chartIndex = 0;

  @override
  Widget build(BuildContext context) {
    final chart = charts[_chartIndex % charts.length];

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Medication Adherence"),
        ),
        body: new Container(
          decoration: new BoxDecoration(
            color: Colors.white,
          ),
          child: new Column(
            children: [
              new Padding(
                padding: new EdgeInsets.all(30.0),
                child: new Text(
                  chart.description,
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.all(20.0),
                child: new Container(
                  child: chart.widget,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.all(30.0),
                child: new Text(
                  chart.description1,
                  //style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        /* floatingActionButton: new FloatingActionButton(
          onPressed: () {
            setState(() => _chartIndex++);
          },
          child: new Icon(Icons.refresh),
        ),*/
      ),
    );
  }
}

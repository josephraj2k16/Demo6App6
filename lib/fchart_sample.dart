import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A city in the world.
@immutable
class City {
  City(this.name, this.size,this.size1);
  final String name;
  int size;
  final int size1;
}
class fchart_dimple extends StatefulWidget {
  fchart_dimple(this.drugName, this.datesInChart);
  String drugName;
  List<DateTime> datesInChart;
  @override
  _fchart_dimpleState createState() => _fchart_dimpleState();
}

/*class _fchart_dimpleState extends State<fchart_dimple> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/



class _fchart_dimpleState extends State<fchart_dimple> {
  int counter=0;
  int counter1=0;
  var x1;
  var de1;
  List<DocumentSnapshot> snapshot;
  List<City> cities=[];
  List<String> date_format=[];

  List<DateTime> dates = [];
  /*[
    DateTime(2019,09,16),
    DateTime(2019,09,17),
    DateTime(2019,09,18),
    DateTime(2019,09,19),
    DateTime(2019,09,20),
    DateTime(2019,09,03),
    DateTime(2019,09,04),
    DateTime(2019,09,05),
    DateTime(2019,09,06),
    *//*"2019-05-14",
    "2019-05-15",
    "2019-05-16",*//*
  ];*/


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //dates.sort((a,b)=>a.compareTo(b));
    dates = widget.datesInChart;
    dates.sort((a, b) {
      return a.compareTo(b);
    });
    for (int j = 0; j < dates.length; j++) {
    //  print("dates after sorting::$dates[j]");
    }

    String formatted1;
    dates.forEach((f) {
     // print("dates:::" + f.toString());
      var formatter = new DateFormat('yyyy-MM-dd');
      String formatted = formatter.format(f);
      Firestore.instance.collection("Prescriptions").document("Intakes")
          .collection(formatted).where("drug_name", isEqualTo: widget.drugName)
          .getDocuments()
          .then((data) {
        if (data.documents.isNotEmpty) {
          de1 = data.documents[0].data;
          DateFormat formatter1 = new DateFormat('MMM-dd');
          formatted1 = formatter1.format(f);
          setState(() {
            counter = de1["counter_ideal"];
            counter1 = de1["counter_actual"];
          });
          //date_format.add(formatted1);
          cities.add(City(formatted1, counter, counter1));
        }else{
          setState(() {

          });
          DateFormat formatter2 = new DateFormat('MMM-dd');
          String formatted2 = formatter2.format(f);
         // date_format.add(formatted1);
          cities.add(City(formatted2, 0, 0));
        }


       // print("Counter_ideal is----$counter");
        //print("Counter_actual is----$counter1");
       // print("formattedddd:::" + formatted1);


        cities.sort((a,b)=> a.name.compareTo(b.name));
        /*for(int i =0; i< dates.length;i++){
          DateFormat formatter2 = new DateFormat('MMM-dd');

          formatted2 = formatter2.format(dates[i]);
          print("new format"+ formatted2);
          //cities.add(City(formatted2, counter, counter1));
        }*/
        /*dates.forEach((i) {
          DateFormat formatter2 = new DateFormat('MMM-dd');
          formatted2.add(formatter2.format(i));
        });
        formatted2.forEach((j) {
          cities.add(City(j, counter, counter1));
        });*/
      });

    });
  }

  //List<City> cities;

  //print("Counter value:"+x.toString());

  @override
  Widget build(BuildContext context) {
    //int x=compute();
    // print("XXXXXXXXX---$x");
    // set x-axis here so that both lines can use it
    final xAxis = new ChartAxis<String>();



    return new AspectRatio(
      aspectRatio: 4 / 3,
      child:new LineChart(
        chartPadding: new EdgeInsets.fromLTRB(60.0, 20.0, 30.0, 30.0),
        lines: [
          // size line
          new Line<City , String, int>(
            data: cities,
            xFn: (city) => city.name,
            yFn: (city) => city.size,
            xAxis: xAxis,
            yAxis: new ChartAxis(
              span: new IntSpan(0, 6),
//              opposite: true,
              tickGenerator: IntervalTickGenerator.byN(1),
              paint: const PaintOptions.stroke(color: Colors.blue),
              tickLabelerStyle: new TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            marker:  MarkerOptions(
              paint: const PaintOptions.fill(color: Colors.blue),
              shape: MarkerShapes.square,
            ),
            stroke: const PaintOptions.stroke(color: Colors.blue),
            legend: new LegendItem(
              paint: const PaintOptions.fill(color: Colors.blue),
              text: 'Ideal',
            ),
          ),
          new Line<City, String, int>(
            data: cities,
            xFn: (city) => city.name,
            yFn: (city) => city.size1,

            xAxis: xAxis,
            yAxis: new ChartAxis(
              span: new IntSpan(0, 6),
//              opposite: true,
              tickGenerator: IntervalTickGenerator.byN(1),
              paint: const PaintOptions.stroke(color: Colors.green),
              tickLabelerStyle: new TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            marker:  MarkerOptions(
              paint:  const PaintOptions.fill(color: Colors.green),
              shape: MarkerShapes.square,
            ),
            stroke: const PaintOptions.stroke(color: Colors.green),
            legend: new LegendItem(
              paint: const PaintOptions.fill(color: Colors.green),
              text: 'Actual',
            ),
          ),

        ],
      ),
    );
  }
}

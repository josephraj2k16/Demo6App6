import 'package:MediAssist/fchart_sample.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


List<DocumentSnapshot> snapshot;
class dimple extends StatefulWidget {
  dimple(this.mrn, this.dateRange);
  String mrn;
  List<DateTime> dateRange;
  @override
  _dimpleState createState() => _dimpleState();
}

class _dimpleState extends State<dimple> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firestore.instance.collection("Prescriptions").document("Intakes").collection("2019-09-05")
        .where("mrn",isEqualTo: widget.mrn).snapshots().listen((data){
      setState(() {
        snapshot=data.documents;
      });
      print("Length===="+snapshot.length.toString());
    });
  }

  void onStart(){

  }

  @override
  Widget build(BuildContext context) {

    //onStart();
    print("Length:"+snapshot.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Medication Adherence"), //widget.title
      ),
      body: ListView.builder(
          itemCount: snapshot.length,
          itemBuilder:(context,int index)=>
            _buildGraph(context, snapshot[index])

          /*{
            if(!snapshot.)
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 8.0),
                new Padding(
                  padding: new EdgeInsets.all(30.0),
                  child: new Text(
                    "Bimatoprost",
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.all(20.0),
                  child: new Container(
                    child: new fchart_dimple(),
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.all(30.0),
                  child: new Text(
                    'X-Axis indicates Date,Y-Axis indicates number of intakes',
                    //style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );*/


      ),
    );

  }


  _buildGraph(BuildContext c, DocumentSnapshot sn){

    print("Inside BUild GRAPH");


   /*return Container(
        child:Column(
          children: <Widget>[
            SizedBox(height: 140.0),
            Text("No Medications on this day"),
          ],
        )
    );*/
    return Container(
      child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(height: 8.0),
        new Padding(
          padding: new EdgeInsets.all(30.0),
          child: new Text(
            sn["drug_name"],
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
        new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Container(
            child: new fchart_dimple(sn["drug_name"], widget.dateRange),
          ),
        ),
        new Padding(
          padding: new EdgeInsets.all(30.0),
          child: new Text(
            'X-Axis indicates Date,Y-Axis indicates number of intakes',
            //style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    );
  }
}

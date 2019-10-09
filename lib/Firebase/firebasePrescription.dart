import 'package:flutter/material.dart';
import 'package:MediAssist/Devefy/ProductCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
//void main() => runApp(MaterialApp(
//      home: MyApp(),
//      debugShowCheckedModeBanner: false,
//    ));

class firebasePrescription extends StatefulWidget {
  @override
  _devefy1 createState() => new _devefy1();
}

class _devefy1 extends State<firebasePrescription> {

  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot> snapshot;
  List<DocumentSnapshot> snapshot1;

  CollectionReference collectionReference =Firestore.instance.collection("Prescription");



  @override
  void initState() {

    super.initState();

    subscription=collectionReference.snapshots().listen((datasnapshot){
      setState(() {
        snapshot=datasnapshot.documents;
      });
    });

    var x=  collectionReference
        .where("mrn",isEqualTo: 1001).snapshots();

     x.listen((onData){
      setState(() {
        snapshot1 = onData.documents;
      });
    });

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: Text("Prescription")),
      backgroundColor: Colors.white,//Color(0xFFddffcc),
      body: new ListView.builder(
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
      ),
//      bottomNavigationBar: Container(
//        height: 70.0,
//        decoration: BoxDecoration(color: Colors.white, boxShadow: [
//          BoxShadow(
//              color: Colors.black12.withOpacity(0.065),
//              offset: Offset(0.0, -3.0),
//              blurRadius: 10.0)
//        ]),
//        child: Row(
//          children: bottomNavIconList.map((item) {
//            var index = bottomNavIconList.indexOf(item);
//            return Expanded(
//              child: GestureDetector(
//                onTap: () {
//                  setState(() {
//                    _currentIndex = index;
//                  });
//                },
//                child: bottomNavItem(item, index == _currentIndex),
//              ),
//            );
//          }).toList(),
//        ),
//      ),
    );
  }
}


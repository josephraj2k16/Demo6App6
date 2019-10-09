import 'package:MediAssist/AccountPage/accountPage.dart';
import 'package:MediAssist/Firebase/cal.dart';
import 'package:MediAssist/Firebase/calendarex.dart';

import 'package:MediAssist/Firebase/firebasePrescription.dart';
import 'package:MediAssist/Models/user.dart';
import 'package:MediAssist/MyAppCalendar.dart';
import 'package:MediAssist/Screens/Login/authentication.dart';
import 'package:MediAssist/Screens/Login/index.dart';
import 'package:MediAssist/Screens/Login/root_page.dart';
import 'package:flutter/material.dart';
import'./main1.dart';
import 'package:MediAssist/Screens/Login/index.dart';
import 'package:date_utils/date_utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:MediAssist/demopage1.dart';
import 'package:MediAssist/demopage.dart';
import './steppermain.dart';
import './expand.dart';

import 'package:MediAssist/Devefy/devefy.dart';

import 'firebase.dart';
import 'package:flutter/material.dart';
import 'package:MediAssist/Devefy/ProductCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class DrawerFirst extends StatefulWidget{
  DrawerFirst({Key key,this.userId,this.auth}):super(key: key);
  final BaseAuth auth;
  final String userId;


  @override
  DrawerOnly createState()=>new DrawerOnly();
}
class DrawerOnly extends State<DrawerFirst> {


  var _formkey = GlobalKey<ScaffoldState>();
  StreamSubscription<QuerySnapshot> subscription;

  List<DocumentSnapshot> snapshot;

  CollectionReference collectionReference =Firestore.instance.collection("Prescription");


  @override
  void initState() {
    super.initState();
//    widget.auth.getCurrentUser().then((user){
//      setState(() {
//        _userId = user.email.toString();
//      });
//    });
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        snapshot = datasnapshot.documents;
      });
    });


  }
  String _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _userId = user.email.toString();
      });
    });
    return _userId;
  }
  var rev12;
  String image ="";
  String getImage(){
    String res1 = _onLoggedIn();
    var res11 = Firestore.instance
        .collection("User_Info")
        .where("email", isEqualTo: res1);
    var snapsht = res11.getDocuments();
    snapsht.then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty){
        rev12=docs.documents[0].data;
      }
    });
    image=rev12["image_url"];

    return image;
  }
  String _userId="";

//  String _onLoggedIn() {
//    widget.auth.getCurrentUser().then((user){
//      setState(() {
//        _userId = user.email.toString();
//      });
//    });
//    return _userId;
//  }
//  var rev;
//  String FullName = "";
//  String getEmail(){
//    String res1 = _onLoggedIn();
//    var res = Firestore.instance
//        .collection("User_Info")
//        .where("email", isEqualTo: res1);
//    var snapsht = res.getDocuments();
//    snapsht.then((QuerySnapshot docs){
//      if(docs.documents.isNotEmpty){
//        rev=docs.documents[0].data;
//      }
//
//    });
//    FullName=rev["first_name"];//+rev["last_name"]
//
//    return FullName;
//    // print(snapshot[0].data["first_name"]);
//
//  }
//
//  Widget getName(){
//    String s1 = getEmail();
//    return Text(
//      s1);
//  }
//  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
//  Widget  _onSignedOut() {
//    setState(() {
//      authStatus = AuthStatus.NOT_LOGGED_IN;
//      _userId = "";
//      Navigator.pushNamed(context, "/login");
//    });
//  }

  @override
  Widget build (BuildContext ctxt) {
    String image1 = getImage();
    return new Drawer(
        child: new ListView(
          children: <Widget>[
            
            new UserAccountsDrawerHeader(


               // accountName: //getName(),
              //  accountEmail: Text("patient@gmail.com"),
                currentAccountPicture: CircleAvatar(
                      minRadius: 28.0,
                    maxRadius: 28.0,
                  backgroundImage: new AssetImage(image1),//rev["image_url"]
                  //padding: EdgeInsets.all(2.0),

                    //Image.asset("images/patientpic.jpg"),

                ),
//                currentAccountPicture:
//                    new AssetImage("images/patientpic.jpg'"),
                  //Image.network('https://hammad-tariq.com/img/profile.png'),
              decoration: BoxDecoration(

                //  image: Image.asset("assets/backimage.jpg"),
                color: Colors.blueAccent,
                image: new DecorationImage(image: new AssetImage('assets/rel3.jpg'),
                  fit: BoxFit.fill,
                ),


              ),
            ),
//            new DrawerHeader(
//              child: new Text("DRAWER HEADER.."),
//              decoration: new BoxDecoration(
//                  color: Colors.lightGreen,
//
//              ),
//            ),
            new ListTile(
              title: new Text("DashBoard"),
              onTap: () {
                Navigator.pop(ctxt);
//                Navigator.push(ctxt,
//                    new MaterialPageRoute(builder: (ctxt) => new demopage()));
              },
            ),
//            new ListTile(
//              title: new Text("Calculate BMI"),
//              onTap: () {
//                Navigator.pop(ctxt);
//                Navigator.push(ctxt,
//                    new MaterialPageRoute(builder: (ctxt) => new StepperPage()));
//              },
//            ),
            new ListTile(
              title: new Text("My Medication Regimen"),
              onTap: () {
                Navigator.pop(ctxt);
                Navigator.push(ctxt,
                    new MaterialPageRoute(builder: (ctxt) => new firebaseCalendarPresc(userId: _userId,
                        auth: widget.auth,
                        title:
                        'Your Medication Regimen')));
              },
            ),
//            new ListTile(
//              title: new Text("About this App"),
//              onTap: () {
//                Navigator.pop(ctxt);
//                Navigator.push(ctxt,
//                    new MaterialPageRoute(builder: (ctxt) => new Criterias()));
//              },
//            ),
            new ListTile(
              title: new Text("Food Interactions"),
              onTap: () {
                Navigator.pop(ctxt);
                Navigator.push(ctxt,
                    new MaterialPageRoute(builder: (ctxt) =>new FoodInteraction(userId: _userId,
                      auth: widget.auth,) ));
              },
            ),
            new ListTile(
              title: new Text("My Account"),
              onTap: () {
                Navigator.pop(ctxt);
                Navigator.push(ctxt,
                    new MaterialPageRoute(builder: (ctxt) => new AccountPage(userId: _userId,
                      auth: widget.auth,)));
              },
            ),
//            new ListTile(
//              title: new Text("Signout"),
//              onTap: () {
//                Navigator.pop(ctxt);
//                Navigator.push(ctxt,
//                    new MaterialPageRoute(builder: (ctxt) =>_onSignedOut()));
//              },
//            ),
//            new ListTile(
//              title: new Text("Demo Page"),
//              onTap: () {
//                Navigator.pop(ctxt);
//                Navigator.push(ctxt,
//                    new MaterialPageRoute(builder: (ctxt) => new firebasePrescription()));
//              },
//            ),
//            new ListTile(
//              title: new Text("Demo Page"),
//              onTap: () {
//                Navigator.pop(ctxt);
//                Navigator.push(ctxt,
//                    new MaterialPageRoute(builder: (ctxt) =>  new firebaseCalendarPresc(title: 'My Medication Regimen')));
//  },
//            ),
//            new ListTile(
//              title: new Text("cal"),
//              onTap: () {
//                Navigator.pop(ctxt);
//                Navigator.push(ctxt,
//                    new MaterialPageRoute(builder: (ctxt) =>  new calendrExam()));
//              },
//            ),
          ],
        )
    );
  }
}


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'Devefy/ProductCard.dart';
import './animated_fab.dart';
import './diagonal_clipper.dart';
import './initial_list.dart';
import './list_model.dart';
import './task_row.dart';
import 'package:flutter/material.dart';
import'./drawer.dart';
import 'Devefy/ProductCard_Doctor.dart';
import 'Screens/Login/authentication.dart';


StreamSubscription<QuerySnapshot> subscription;
List<DocumentSnapshot> snapshot;
CollectionReference collectionReference =Firestore.instance.collection("Prescription");


class PatientPage extends StatefulWidget{
  PatientPage({Key key, this.auth, this.userId,this.user, this.onSignedOut})
      : super(key: key);
  final BaseAuth auth;
  final String user;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  PatientPageState createState() => new PatientPageState();
}


class PatientPageState extends State<PatientPage> {
  String _userId="";
  String _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _userId = user.email.toString();
      });
    });
    print(_userId);
    return _userId;
  }
  var rev;
  var rev1;
  var rev12;
  String FullName = "";
  String address = "";
  String image = "";
  String getEmail(){
    String res1 = _onLoggedIn();
    var res = Firestore.instance
        .collection("User_Info")
        .where("email", isEqualTo: res1);
    var snapsht = res.getDocuments();
    snapsht.then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty){
        rev=docs.documents[0].data;
      }
    });
    FullName=rev["first_name"];

    return FullName;
  }
  /*String getBio(){
    String res1 = _onLoggedIn();
    var res11 = Firestore.instance
        .collection("User_Info")
        .where("email", isEqualTo: res1);
    var snapsht = res11.getDocuments();
    snapsht.then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty){
        rev1=docs.documents[0].data;
      }
    });
    address=rev1["address"];

    return address;
  }*/
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
//  Widget getName(){
//    String s1 = getEmail();
//    return new Text(
//      s1,
//      //"Hi",
//      style: new TextStyle(
//          fontSize: 26.0,
//          color: Colors.black,
//          fontWeight: FontWeight.w400),
//    );
//  }
  Widget _buildFullName() {
    String s1 = getEmail();
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      s1,
      style: _nameTextStyle,
    );
  }
  String _fullName = "James Smith";
  //String _status = "PCP:Emma Brown";
  String _bio =
      "64,Ashok nagar 4th street koodal nagar madurai-18";
  String _followers = "173";
  String _posts = "24";
  String _scores = "450";

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/rel4.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }


  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'RalewayItalic',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Posts", _posts),
          _buildStatItem("Scores", _scores),
        ],
      ),
    );
  }

  /*Widget _buildBio(BuildContext context) {

    String bio1 = getBio();
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,
      //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        bio1,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }*/
  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  void onStart() {
    subscription = collectionReference.where("mrn", isEqualTo: widget
        .user) //.where("start_date",isLessThanOrEqualTo: formatted)
        .snapshots().listen((dataSnapshot) {
      setState(() {
        snapshot = dataSnapshot.documents;
      });
    });
  }
  //.getDocuments();
//  de.then((onValue) {
//  if (onValue.documents.isNotEmpty) {
//  de1 = onValue.documents[0].data;
//  }
//  fr = de1["mrn"];
  String getTitle(String title){
    if(title=="Bimatoprost"){
      return "User1";
    }else if(title=="Injection Ranitidine 50mg/2ml"){
      return "User2";
    }else if(title=="Mupirocin Oinment"){
      return "User3";
    }else if(title=="Ascorbic acid 500mg"){
      return "User4";
    }else if(title=="Paracetamol 500mg"){
      return "tab5";
    }else if(title=="Enalapril 5mg"){
      return "tab6";
    }else if(title=="Ferrous Sulphate 325mg"){
      return "tab7";
    }else if(title=="Warfarin 2mg"){
      return "tab8";
    }
  }
  String io=" ";
  String io1=" ";
  String io2=" ";
  String passdata(String d){
    io=d.toString();
    return io;
  }
  String passdata1(String d){
    io1=d.toString();
    return io1;
  }
  String passdata2(String d){
    io2=d.toString();
    return io2;
  }

  Widget _buildItems(BuildContext c,DocumentSnapshot sn){
    var de1;
    String fr1=" ";
    var de2;
    String fr2=" ";
    var de3;
    String fr3=" ";
    String xs=getTitle(sn["drug_name"]);
    var x = collectionReference.document(xs).collection("Intake_time")
            .document("Intake").collection("8.00-10.00AM").document("8.00-10.00AM").snapshots();//.getDocuments()
    var x1 = collectionReference.document(xs).collection("Intake_time")
        .document("Intake").collection("1.00-2.00PM").document("1.00-2.00PM").snapshots();
    var x2 = collectionReference.document(xs).collection("Intake_time")
        .document("Intake").collection("8.00-9.00PM").document("8.00-9.00PM").snapshots();

//    x.then((onVal) {
//      if (onVal.documents.isNotEmpty) {
//        de2 = onVal.documents[0].data;
//      }
//      fr2 = de2["time_taken"];
//
//    }).catchError((e){
//      print(e);
//    });
    x.listen((data){
      setState(() {
         de1=data["time_taken"];
         passdata(de1.toString());
        //String fr11=de1.toString();
      });
    });
    //print(io.toString());


    x1.listen((data){
      setState(() {
        de2=data["time_taken"];
        passdata1(de2.toString());
      });
    });

    x2.listen((data){
      setState(() {
        de3=data["time_taken"];
        passdata2(de3.toString());
      });
    });
    
    return new ExpansionTile(
              title: new Text(sn["drug_name"],style: TextStyle(fontSize: 18.5,
                  color: Colors.black,
                  fontFamily: "Helvetica")),
              children: <Widget>[

                new Text("8.00-10.00AM : "+io,style: TextStyle(fontSize: 18.5,
                    color: Colors.black,
                    fontFamily: "Helvetica")),
                new Text("1.00-2.00PM : "+io1,style: TextStyle(fontSize: 18.5,
                    color: Colors.black,
                    fontFamily: "Helvetica")),
                new Text("8.00-9.00PM : "+io2,style: TextStyle(fontSize: 18.5,
                    color: Colors.black,
                    fontFamily: "Helvetica")),
              ],
            );
  }
  @override
  Widget build(BuildContext context) {
    onStart();
    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      //title: "User Profile",
      debugShowCheckedModeBanner: false,
      //
      home:// UserProfilePage(),

      new Scaffold(
        appBar:new  AppBar(
          title: Text("Medication Adherence"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Logout", style: new TextStyle(fontSize: 17.0, color: Colors.white),),
              onPressed:_signOut,
            )
          ],

        ),
        body:
          ListView.builder(
          itemCount: snapshot.length,
          itemBuilder: (BuildContext context,index)=>

            _buildItems(context,snapshot[index]),
          ),
      ),
    );
  }
}




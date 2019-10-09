import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Screens/Login/authentication.dart';

StreamSubscription<QuerySnapshot> subscription1;
List<DocumentSnapshot> snapshot1;

CollectionReference collectionReference =
Firestore.instance.collection("Prescription");
CollectionReference collectionReference1 =
Firestore.instance.collection("food_interactions");
CollectionReference userInfo = Firestore.instance.collection("User_Info");

class DrugInteraction extends StatefulWidget {
  DrugInteraction({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  _DrugInteractionState createState() => new _DrugInteractionState();
}

class _DrugInteractionState extends State<DrugInteraction> {
  String _userId = "";

  String _onLoggedIn() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.email.toString();
      });
    });
    return _userId;
  }

  var rev;
  var rev1;
  var rev12;
  String FullName = "";
  String address = "";
  String image = "";
  var de1;
  var doo1;
  String mrn_value = "";
  String food_url = "";

  String getEmail() {
    String res1 = _onLoggedIn();
    var res = Firestore.instance
        .collection("User_Info")
        .where("email", isEqualTo: res1);
    var snapsht = res.getDocuments();
    snapsht.then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        rev = docs.documents[0].data;
      }
    });
    FullName = rev["first_name"];

    return FullName;
  }

  /* String getImage(){

    String res1 = _onLoggedIn();
    */ /*var res11 = Firestore.instance
        .collection("User_Info")
        .where("email", isEqualTo: res1);*/ /*
    var res11 = userInfo.where("email", isEqualTo: res1).getDocuments();
    res11.then((onValue) {
      if (onValue.documents.isNotEmpty) {
        de1 = onValue.documents[0].data;
      }
      mrn_value = de1["mrn"];
      print("mrn_value"+mrn_value);
      var doo = collectionReference
          .where("mrn", isEqualTo: mrn_value)
          .getDocuments(); //.where("start_date",isLessThanOrEqualTo: formatted)
      doo.then((onVal) {
        if (onValue.documents.isNotEmpty) {
          doo1 = onValue.documents[0].data;
        }
      });
    });
    food_url = doo1["food_img"];
    return food_url;
  }*/

  /* Widget _buildProfileImage() {

    String image1 = getImage();
    print("Image11"+image1);
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image1),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),
        ),
      ),
    );
  }*/

  void onStart() {
    var de1;
    var doo1;
    String fr = "";
    String fr1 = "";
    String user = _onLoggedIn();
    var de = userInfo.where("email", isEqualTo: user).getDocuments();
    de.then((onValue) {
      if (onValue.documents.isNotEmpty) {
        de1 = onValue.documents[0].data;
      }
      fr = de1["mrn"];
    //  print(fr);
      var doo = collectionReference
          .where("mrn", isEqualTo: fr)
          .getDocuments(); //.where("start_date",isLessThanOrEqualTo: formatted)
      doo.then((onVal) {
        if (onValue.documents.isNotEmpty) {
          doo1 = onValue.documents[0].data;
        }
        // fr1 = doo1["mrn"];
        fr1 = doo1["message"];
        data(fr1);
       // print("OnStart value:" + fr1);
        //print(fr1);
        //return fr1;
      });
    });
  }

  String ss = "";

  String data(String d) {
    ss = d.toString();
    return ss;
  }

  void onFood() {
    var de1;
    var doo1;
    String fr = "";
    String fr1 = "";
    String user = _onLoggedIn();
    var de = userInfo.where("email", isEqualTo: user).getDocuments();
    de.then((onValue) {
      if (onValue.documents.isNotEmpty) {
        de1 = onValue.documents[0].data;
      }
      fr = de1["mrn"];
      //print(fr);
      var doo = collectionReference
          .where("mrn", isEqualTo: fr)
          .getDocuments(); //.where("start_date",isLessThanOrEqualTo: formatted)
      doo.then((onVal) {
        if (onValue.documents.isNotEmpty) {
          doo1 = onValue.documents[0].data;
        }
        // fr1 = doo1["mrn"];
        fr1 = doo1["food_img"];
        data1(fr1);
      });
    });
  }

  String data1(String d) {
    image = d.toString();
    return image;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    onStart();
    onFood();
    return MaterialApp(
      //title: "User Profile",
        debugShowCheckedModeBanner: false,
        //
        home: // UserProfilePage(),

        new Scaffold(
          appBar: new AppBar(
            title: Text("Drug Interactions"),
            leading: InkWell(
              //onTap:  ()=>{null},
              onTap:() => Navigator.pop(context, false),
              child: Icon(Icons.arrow_back,),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              SizedBox(height: 240.0),
              Center(

                  child: Text("No Serious Drug Interactions Assigned",style:TextStyle(fontSize: 18.0,fontFamily: 'Helvetica')),
              ) 

            ],/* SizedBox(
                height: 15.0,
              ),
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                elevation: 10.0,
                margin: EdgeInsets.all(2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    new Text(""),
                    new Text(ss,
                        style: TextStyle(
                            fontSize: 18.5,
                            color: Colors.black,
                            fontFamily: "Helvetica")),
                    new Text(""),
                  ],
                ),
              ),*/
          ),
        ));
  }
}

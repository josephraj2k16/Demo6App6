import 'dart:async';

import 'package:MediAssist/AccountPage/accountPage.dart';
import 'package:MediAssist/Firebase/cal.dart';
import 'package:MediAssist/MyAppCalendar.dart';
import 'package:MediAssist/Screens/Login/authentication.dart';
import 'package:MediAssist/Screens/Login/index.dart';
import 'package:MediAssist/drawer.dart';
import 'package:MediAssist/firebase.dart';
import 'package:MediAssist/DrugInteractions.dart';
import 'package:MediAssist/main1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MediAssist/Screens/Login/login_signup_page.dart';
import 'package:flutter/material.dart';
import 'Medicine.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.auth, this.userId,this.onSignedOut})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  String firstName;
  String LastName;
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;


  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
 String _userId="";
//
  String _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _userId = user.email.toString();
      });
    });
    return _userId;
  }
    var rev;
    String FullName = "";
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
      FullName=rev["first_name"];//+rev["last_name"]

      return FullName;
//     // print(snapshot[0].data["first_name"]);
//
   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    widget.auth.getCurrentUser().then((user){
//      setState(() {
//        _userId = user.email.toString();
//      });
//    });

  }

          //print(snapshot.length);
//
//          var res1 = snapshot[0].data["first_name"];
//          print("result set " + res1);
    Widget getName(){
      String s1 = getEmail();
     return new Text(
       s1,
       //"Hi",
        style: new TextStyle(
            fontSize: 26.0,
            color: Colors.black,
            fontWeight: FontWeight.w400),
      );
    }

  Widget _buildImage() {
    return new Row(
      children: <Widget>[
        new CircleAvatar(
          minRadius: 28.0,
          maxRadius: 28.0,
          backgroundImage: new AssetImage('images/patientpic.jpg'),
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getName(),
//              new Text(
//                'Sophia ',
//                style: new TextStyle(
//                    fontSize: 26.0,
//                    color: Colors.black,
//                    fontWeight: FontWeight.w400),
//              ),
//              new Text(
//                'Williams',
//                style: new TextStyle(
//                    fontSize: 14.0,
//                    color: Colors.black,
//                    fontWeight: FontWeight.w300),
//              ),
            ],
          ),
        ),
      ],
    );
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
   // getEmail();

    return Scaffold(
      drawer: new DrawerFirst(userId: _userId,
          auth: widget.auth,), //imported from drawer.dart

      body: CustomScrollView(
        // headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Medication Adherence",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                )),
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: _buildImage(),

//                  Text("Collapsing Toolbar",
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 16.0,
//                      )),
              background: Image.asset(
                "assets/bi3.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Card(
                        elevation: 10.0,
                        child: new Container(
                            height: 125,
                            width: 150,
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new firebaseCalendarPresc(userId: _userId,
                                            auth: widget.auth,
                                            title:
                                                'Your Medication Regimen')));
                              },
                              child: new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Icon(
                                    Icons.alarm_add,
                                    size: 50.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 30.0),
                                    child: new Text(
                                      "My Medication Regimen",
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                    new Card(
                        elevation: 10.0,
                        child: new Container(
                            height: 125,
                            width: 150,
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => AccountPage(userId: _userId,
                                          auth: widget.auth,
                                          //email: _email,
                                          )));
                              },
                              child: new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Icon(
                                    Icons.account_circle,
                                    size: 50.0,
                                  ),
                                  new Text(
                                    "My Account",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ))),
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Card(
                        elevation: 10.0,
                        child: new Container(
                            height: 125,
                            width: 150,
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new FoodInteraction(
                                          userId: _userId,
                                          auth: widget.auth,
                                        )));
                              },
                              child: new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Icon(
                                    Icons.fastfood,
                                    size: 50.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 30.0),
                                    child: new Text("Food Interactions",
                                        style: TextStyle(fontSize: 20.0)),
                                  ),
                                ],
                              ),
                            ))),
                    new Card(elevation: 10.0,
                        child: new Container(
                            height: 125,
                            width: 150,
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new DrugInteraction(
                                          userId: _userId,
                                          auth: widget.auth,
                                        )));
                              },
                              child: new Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  new Icon(
                                   Icons.local_hospital,
                                    //Medicines.drug,
                                    size: 50.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 30.0),
                                    child: new Text("Drug Interactions",
                                        style: TextStyle(fontSize: 20.0)),
                                  ),
                                ],
                              ),
                            ))),
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Card(
                        elevation: 10.0,
                        child: new Container(
                            height: 125,
                            width: 150,
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                _signOut();
//                                setState() {
//
//                                }
                              },
                              child: new Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Icon(
                                    Icons.power_settings_new,
                                    size: 50.0,
                                  ),
                                  new Text(
                                    "SignOut",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ))),
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

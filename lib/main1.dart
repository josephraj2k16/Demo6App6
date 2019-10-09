import 'package:MediAssist/chart_example.dart';
import 'package:MediAssist/dimple.dart';
import 'package:MediAssist/fchart_sample.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Devefy/ProductCard.dart';
import './animated_fab.dart';
import './diagonal_clipper.dart';
import './initial_list.dart';
import './list_model.dart';
import './task_row.dart';
import 'package:flutter/material.dart';
import './drawer.dart';
import 'Devefy/ProductCard_Doctor.dart';
import './PatientPage.dart';
import 'Screens/Login/authentication.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

List<DateTime> days1 = [];
class DoctorPage extends StatefulWidget {
  DoctorPage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  DoctorPageState createState() => new DoctorPageState();
}

class DoctorPageState extends State<DoctorPage> {
  String _userId = "";

  String _onLoggedIn() {
    widget.auth.getCurrentUser().then((user) {
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

  String getImage() {
    String res1 = _onLoggedIn();
    var res11 = Firestore.instance
        .collection("User_Info")
        .where("email", isEqualTo: res1);
    var snapsht = res11.getDocuments();
    snapsht.then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        rev12 = docs.documents[0].data;
      }
    });
    image = rev12["image_url"];

    return image;
  }


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
  String _bio = "64,Ashok nagar 4th street koodal nagar madurai-18";
  String _followers = "173";
  String _posts = "24";
  String _scores = "450";


  Widget _buildProfileImage() {
    //const NeverScrollableScrollPhysics({ ScrollPhysics parent }) : super(parent: parent);
    String image1 = getImage();
    return Center(
      child: Container(
        width: 120.0,
        height: 120.0,
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
  }

/*  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
      // _status,
        style: TextStyle(
          fontFamily: 'Raleway',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }*/

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

  @override
  Widget build(BuildContext context) {
    String user1 = "1001";
    String user2 = "1002";
    String user3 = "1003";
    DateTime fro1;
    DateTime to1;
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return MaterialApp(
      //title: "User Profile",
      debugShowCheckedModeBanner: false,
      //
      home: // UserProfilePage(),

      new Scaffold(
//            drawer: new DrawerFirst(
//               userId: _userId,
//               auth: widget.auth,
//            ), //imported from drawer.dart
          appBar: new AppBar(
            title: Text("Welcome Doctor"),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "Logout",
                  style: new TextStyle(fontSize: 17.0, color: Colors.white),
                ),
                onPressed: _signOut,
              )
            ],

          ),
          body: //new Text("Hi there"),
          ListView(
            padding: EdgeInsets.all(8.0),
            children: <Widget>[
              Card(
                elevation: 10.0,
                margin: EdgeInsets.all(2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                        borderRadius: BorderRadius.circular(8),
                      /*  onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                  new dimple(
                                      user1) //new FChartsExampleApp(user1)
                                // /*PatientPage(userId: _userId,user: user1,
                                //auth: widget.auth,
                                //email: _email,
                                // )*/
                              ));
                        },*/
                        child: new Column(
                          children: <Widget>[

                            new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  minRadius: 28.0,
                                  maxRadius: 28.0,
                                  backgroundImage: new AssetImage(
                                      'assets/avatars/avatar-1.jpg'),
                                ),
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(""),
                                    new Text("James Smith",
                                        style: TextStyle(fontSize: 18.5,
                                          color: Colors.black,
                                          fontFamily: "Helvetica",
                                        )),
                                    new SizedBox(
                                      height: 5.0,
                                    ),
                                    new Text(
                                      "21-13 Syndham street worchestor london",
                                      style:
                                      TextStyle(
                                        fontFamily: 'Spectral',
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF799497),
                                        fontSize: 16.0,
                                      ),),
                                    new Text(""),
                                  ],
                                )

                              ],

                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            22.0)),
                                    elevation: 18.0,
                                    padding: EdgeInsets.fromLTRB(
                                        35.0, 10.0, 35.0, 10.0),
                                    color: Colors.blue,
                                    onPressed: () async {
                                      final List<
                                          DateTime> picked = await DateRagePicker
                                          .showDatePicker(
                                          context: context,
                                          initialFirstDate: new DateTime.now(),
                                          initialLastDate:
                                          (new DateTime.now()).add(
                                              new Duration(days: 4)),
                                          firstDate: new DateTime(2015),
                                          lastDate: new DateTime(2022));
                                      if (picked != null && picked[1]
                                          .difference(picked[0])
                                          .inDays < 5) {
                                        fro1 = picked[0];
                                        to1 = picked[1];
                                        List<DateTime> days = [];
                                        DateFormat formatter1 = new DateFormat(
                                            'yyyy-MM-dd');
                                        List<String> formatted1;
                                        for (int i = 0; i <= to1
                                            .difference(fro1)
                                            .inDays; i++) {
                                          days.add(
                                              fro1.add(Duration(days: i)));
                                        }
                                        days.forEach((d1) => print(
                                            "picker datesss--" +
                                                formatter1.format(d1)));
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                  new dimple(
                                                      user1, days) //new FChartsExampleApp(user1)
                                                // /*PatientPage(userId: _userId,user: user1,
                                                //auth: widget.auth,
                                                //email: _email,
                                                // )*/
                                              ));
                                      } else if(picked != null && picked[1]
                                          .difference(picked[0])
                                          .inDays >= 5) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("Alert"),
                                              content: Text("Pick dates less than or equal to 5 days"),
                                              actions: <Widget>[
                                                new FlatButton(
                                                    child: new Text(" Ok "),
                                                  onPressed: (){
                                                      Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            )
                                        );

                                      }else{
                                        print("elseeeeeeeess");
                                      }
                                    },
                                    child: new Text("Pick date range",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),)),
                                new SizedBox(
                                  width: 15.0,
                                ),
                                new RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                  ),
                                  elevation: 18.0,
                                  padding: EdgeInsets.fromLTRB(
                                      35.0, 10.0, 35.0, 10.0),
                                  onPressed: () {},
                                  child: new Text("See FeedBack"),
                                )
                                /* new MaterialButton(
                                    //color: Colors.lightGreen,

                                    shape: RoundedRectangleBorder(
                                      borderRadius:BorderRadius.circular(22.0),
                                    ),
                                    elevation: 18.0,
                                    minWidth: 150.0,
                                    height: 35,
                                    onPressed: (){ },
                                    child: new Text("See Feedback")),*/
                              ],

                            ),
                            new SizedBox(
                              height: 15.0,
                            ),
                          ],
                        )


                      //new Text("HI hwerw"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Card(
                elevation: 10.0,
                margin: EdgeInsets.all(2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                        borderRadius: BorderRadius.circular(8),
                        /*  onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                  new dimple(
                                      user1) //new FChartsExampleApp(user1)
                                // /*PatientPage(userId: _userId,user: user1,
                                //auth: widget.auth,
                                //email: _email,
                                // )*/
                              ));
                        },*/
                        child: new Column(
                          children: <Widget>[

                            new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  minRadius: 28.0,
                                  maxRadius: 28.0,
                                  backgroundImage: new AssetImage(
                                      'assets/avatars/avatar-2.jpg'),
                                ),
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(""),
                                    new Text("Michael Smith",
                                        style: TextStyle(fontSize: 18.5,
                                          color: Colors.black,
                                          fontFamily: "Helvetica",
                                        )),
                                    new SizedBox(
                                      height: 5.0,
                                    ),
                                    new Text(
                                      " 12-76 Wilhelm street dorchestor london",
                                      style:
                                      TextStyle(
                                        fontFamily: 'Spectral',
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF799497),
                                        fontSize: 16.0,
                                      ),),
                                    new Text(""),
                                  ],
                                )

                              ],

                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            22.0)),
                                    elevation: 18.0,
                                    padding: EdgeInsets.fromLTRB(
                                        35.0, 10.0, 35.0, 10.0),
                                    color: Colors.blue,
                                    onPressed: () async {
                                      final List<
                                          DateTime> picked = await DateRagePicker
                                          .showDatePicker(
                                          context: context,
                                          initialFirstDate: new DateTime.now(),
                                          initialLastDate:
                                          (new DateTime.now()).add(
                                              new Duration(days: 4)),
                                          firstDate: new DateTime(2015),
                                          lastDate: new DateTime(2022));
                                      if (picked != null && picked[1]
                                          .difference(picked[0])
                                          .inDays < 5) {
                                        fro1 = picked[0];
                                        to1 = picked[1];
                                        List<DateTime> days = [];
                                        DateFormat formatter1 = new DateFormat(
                                            'yyyy-MM-dd');
                                        List<String> formatted1;
                                        for (int i = 0; i <= to1
                                            .difference(fro1)
                                            .inDays; i++) {
                                          days.add(
                                              fro1.add(Duration(days: i)));
                                        }
                                        days.forEach((d1) => print(
                                            "picker datesss--" +
                                                formatter1.format(d1)));
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                new dimple(
                                                    user2, days) //new FChartsExampleApp(user1)
                                              // /*PatientPage(userId: _userId,user: user1,
                                              //auth: widget.auth,
                                              //email: _email,
                                              // )*/
                                            ));
                                      } else if(picked != null && picked[1]
                                          .difference(picked[0])
                                          .inDays >= 5) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("Alert"),
                                              content: Text("Pick dates less than or equal to 5 days"),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text(" Ok "),
                                                  onPressed: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            )
                                        );

                                      }else{
                                        print("elseeeeeeeess");
                                      }
                                    },
                                    child: new Text("Pick date range",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),)),
                                new SizedBox(
                                  width: 15.0,
                                ),
                                new RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                  ),
                                  elevation: 18.0,
                                  padding: EdgeInsets.fromLTRB(
                                      35.0, 10.0, 35.0, 10.0),
                                  onPressed: () {},
                                  child: new Text("See FeedBack"),
                                )
                                /* new MaterialButton(
                                    //color: Colors.lightGreen,

                                    shape: RoundedRectangleBorder(
                                      borderRadius:BorderRadius.circular(22.0),
                                    ),
                                    elevation: 18.0,
                                    minWidth: 150.0,
                                    height: 35,
                                    onPressed: (){ },
                                    child: new Text("See Feedback")),*/
                              ],

                            ),
                            new SizedBox(
                              height: 15.0,
                            ),
                          ],
                        )


                      //new Text("HI hwerw"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Card(
                elevation: 10.0,
                margin: EdgeInsets.all(2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                        borderRadius: BorderRadius.circular(8),
                        /*  onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) =>
                                  new dimple(
                                      user1) //new FChartsExampleApp(user1)
                                // /*PatientPage(userId: _userId,user: user1,
                                //auth: widget.auth,
                                //email: _email,
                                // )*/
                              ));
                        },*/
                        child: new Column(
                          children: <Widget>[

                            new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  minRadius: 28.0,
                                  maxRadius: 28.0,
                                  backgroundImage: new AssetImage(
                                      'assets/avatars/avatar-3.jpg'),
                                ),
                                new Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(""),
                                    new Text("Maria Gracia",
                                        style: TextStyle(fontSize: 18.5,
                                          color: Colors.black,
                                          fontFamily: "Helvetica",
                                        )),
                                    new SizedBox(
                                      height: 5.0,
                                    ),
                                    new Text(
                                      "16-76 Trellawny street Clapham london",
                                      style:
                                      TextStyle(
                                        fontFamily: 'Spectral',
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF799497),
                                        fontSize: 16.0,
                                      ),),
                                    new Text(""),
                                  ],
                                )

                              ],

                            ),
                            new SizedBox(
                              height: 10.0,
                            ),
                            new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            22.0)),
                                    elevation: 18.0,
                                    padding: EdgeInsets.fromLTRB(
                                        35.0, 10.0, 35.0, 10.0),
                                    color: Colors.blue,
                                    onPressed: () async {
                                      final List<
                                          DateTime> picked = await DateRagePicker
                                          .showDatePicker(
                                          context: context,
                                          initialFirstDate: new DateTime.now(),
                                          initialLastDate:
                                          (new DateTime.now()).add(
                                              new Duration(days: 4)),
                                          firstDate: new DateTime(2015),
                                          lastDate: new DateTime(2022));
                                      if (picked != null && picked[1]
                                          .difference(picked[0])
                                          .inDays < 5) {
                                        fro1 = picked[0];
                                        to1 = picked[1];
                                        List<DateTime> days = [];
                                        DateFormat formatter1 = new DateFormat(
                                            'yyyy-MM-dd');
                                        List<String> formatted1;
                                        for (int i = 0; i <= to1
                                            .difference(fro1)
                                            .inDays; i++) {
                                          days.add(
                                              fro1.add(Duration(days: i)));
                                        }
                                        days.forEach((d1) => print(
                                            "picker datesss--" +
                                                formatter1.format(d1)));
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                new dimple(
                                                    user3, days) //new FChartsExampleApp(user1)
                                              // /*PatientPage(userId: _userId,user: user1,
                                              //auth: widget.auth,
                                              //email: _email,
                                              // )*/
                                            ));
                                      } else if(picked != null && picked[1]
                                          .difference(picked[0])
                                          .inDays >= 5) {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("Alert"),
                                              content: Text("Pick dates less than or equal to 5 days"),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  child: new Text(" Ok "),
                                                  onPressed: (){
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            )
                                        );

                                      }else{
                                        print("elseeeeeeeess");
                                      }
                                    },
                                    child: new Text("Pick date range",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),)),
                                new SizedBox(
                                  width: 15.0,
                                ),
                                new RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                  ),
                                  elevation: 18.0,
                                  padding: EdgeInsets.fromLTRB(
                                      35.0, 10.0, 35.0, 10.0),
                                  onPressed: () {},
                                  child: new Text("See FeedBack"),
                                )
                                /* new MaterialButton(
                                    //color: Colors.lightGreen,

                                    shape: RoundedRectangleBorder(
                                      borderRadius:BorderRadius.circular(22.0),
                                    ),
                                    elevation: 18.0,
                                    minWidth: 150.0,
                                    height: 35,
                                    onPressed: (){ },
                                    child: new Text("See Feedback")),*/
                              ],

                            ),
                            new SizedBox(
                              height: 15.0,
                            ),
                          ],
                        )


                      //new Text("HI hwerw"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              /*Card(
                elevation: 10.0,
                margin: EdgeInsets.all(2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new dimple(user2 ,days1)
                              )
                          );
                        },
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new CircleAvatar(
                              minRadius: 28.0,
                              maxRadius: 28.0,
                              backgroundImage: new AssetImage(
                                  'assets/avatars/avatar-2.jpg'),
                            ),
                            new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Text(""),
                                new Text("Michael Smith",
                                    style: TextStyle(fontSize: 18.5,
                                        color: Colors.black,
                                        fontFamily: "Helvetica")),
                                new Text(
                                  "12-76 Wilhelm street dorchestor london",
                                  style:
                                  TextStyle(
                                    fontFamily: 'Spectral',
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFF799497),
                                    fontSize: 16.0,
                                  ),),
                                new Text(""),
                              ],
                            )

                          ],

                        )


                      //new Text("HI hwerw"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Card(
                elevation: 10.0,
                margin: EdgeInsets.all(2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new dimple(user3, days1)
                              )
                          );
                        },
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new CircleAvatar(
                              minRadius: 28.0,
                              maxRadius: 28.0,
                              backgroundImage: new AssetImage(
                                  'assets/avatars/avatar-3.jpg'),
                            ),
                            new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Text("Maria Gracia",
                                    style: TextStyle(fontSize: 18.5,
                                        color: Colors.black,
                                        fontFamily: "Helvetica")),
                                new Text(
                                  "16-76 Trellawny street Clapham london",
                                  style:
                                  TextStyle(
                                    fontFamily: 'Spectral',
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFF799497),
                                    fontSize: 16.0,
                                  ),),
                                new Text(""),
                              ],
                            )

                          ],

                        )


                      //new Text("HI hwerw"),
                    ),
                  ],
                ),
              )*/
            ],

          )
//        Stack(children: <Widget>[
//          _buildCoverImage(screenSize),
//          SafeArea(
//            child: SingleChildScrollView(
//              child: Column(children: <Widget>[
//                SizedBox(height: screenSize.height / 4.0),
//                _buildProfileImage(),
//                _buildFullName(),
//                //_buildStatus(context),
//                //_buildStatContainer(),
//                //_buildBio(context),
//                _buildSeparator(screenSize),
//                SizedBox(height: 6.0),
//                //_buildGetInTouch(context),
//                SizedBox(height: 6.0),
//                /*Card(
//                  child: new Padding(
//                      padding: new EdgeInsets.all(15.0),
//                      child: new Column(children: <Widget>[
//                        new SizedBox(
//                          height: 184.0,
//                          child: new Stack(
//                            children: <Widget>[
//                              new Positioned.fill(
//                                child: new Image.asset(
//                                  "assets/avatars/avatar-1.jpg",
//                                  //package: destination.assetPackage,
//                                  fit: BoxFit.contain,
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                        new Padding(
//                          padding: new EdgeInsets.all(
//                            7.0,
//                          ),
//                          child: new Text(
//                            "James Smith",
//                            style: new TextStyle(
//                                fontSize: 14.0,
//                                fontWeight: FontWeight.w600,
//                                color: Colors.black87),
//                          ),
//                        ),
//                        new Padding(
//                          padding: new EdgeInsets.all(
//                            0.0,
//                          ),
//                          child: new Text(
//                            "21-13 Syndham street worchestor london ",
//                            style: new TextStyle(
//                                fontSize: 12.0,
//                                fontWeight: FontWeight.w400,
//                                color: Colors.black54),
//                          ),
//                        ),
//                      ])),
//                ),*/
//              /*  new Positioned.fill(
//                    child: new Material(
//                        color: Colors.transparent,
//                        child: new InkWell(
//                          onTap: () {
//                            Navigator.push(
//                                context,
//                                new MaterialPageRoute(
//                                    builder: (context) => PatientPage(
//                                          userId: _userId,
//                                          auth: widget.auth,
//                                          //email: _email,
//                                        )));
//                          },
//                        )))*/
//                InkWell(
//
//                  onTap: () {
//                    Navigator.push(
//                        context,
//                        new MaterialPageRoute(
//                            builder: (context) => PatientPage(userId: _userId,
//                              auth: widget.auth,
//                              //email: _email,
//                            )));
//                  },
//
//
//
//
//
//
//
//                child: new Text(
//                  "James Smith",
//                  style: new TextStyle(
//                      fontSize: 14.0,
//                      fontWeight: FontWeight.w600,
//                      color: Colors.black87),
//                ),
//              ),
//
//                  /*child: new Column(
//                    mainAxisAlignment:
//                    MainAxisAlignment.spaceEvenly,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      new Icon(
//                        Icons.account_circle,
//                        size: 50.0,
//                      ),
//                      new Text(
//                        "James Smith",
//                        style: TextStyle(fontSize: 20.0),
//                      ),
//                    ],
//                  ),*/
//
//            ]
//                ),
//
//                  /*  children: <Widget>[
//
//
//                              */ /*ProductCard_Doctor(
//                                0xFFccff66,
//                                "assets/avatars/avatar-1.jpg",
//                                "James Smith",
//                                "21-13 Syndham street worchestor london ",
//                              ),*/ /*
//                        InkWell(
//                          onTap: () {
//                            Navigator.push(
//                                context,
//                                new MaterialPageRoute(
//                                    builder: (context) => PatientPage(userId: _userId,
//                                      auth: widget.auth,
//                                      //email: _email,
//                                    )));
//                          },
//                      ),
//
//                          */ /*ProductCard_Doctor(
//                            0xFFccff66,
//                            "assets/avatars/avatar-2.jpg",
//                            "Michael Smith",
//                            "12-76 Wilhelm street dorchestor london",
//                          ),
//                          SizedBox(
//                            height: 30.0,
//                          ),
//                          ProductCard_Doctor(
//                            0xFFccff66,
//                            "assets/avatars/avatar-4.jpg",
//                            "Maria Gracia",
//                            "16-76 Trellawny street Clapham london",
//                          ),
//                          SizedBox(
//                            height: 30.0,
//                          ),
//                          SizedBox(
//                            height: 30.0,
//                          ),*/ /*
//                        ],*/
//                  ),
//            ),
//            ]
//           //_buildButtons(),
//        ),
      ),
    );
  }
}

/*Widget _buildButtons() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () => print("followed"),
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                border: Border.all(),
                color: Color(0xFF404A5C),
              ),
              child: Center(
                child: Text(
                  "FOLLOW",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: InkWell(
            onTap: () => print("Message"),
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "MESSAGE",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}*/

//  @override
//  Widget build(BuildContext context) {
//    Size screenSize = MediaQuery.of(context).size;
//    return new Scaffold(
//      appBar:new  AppBar(
//        title: Text("My Account"),
//
//        leading: InkWell(
//          onTap:  ()=>{},
//          child: Icon(Icons.arrow_back,),
//        ),
//
//      ),
//      body: Stack(
//        children: <Widget>[
//          _buildCoverImage(screenSize),
//          SafeArea(
//            child: SingleChildScrollView(
//              child: Column(
//                children: <Widget>[
//                  SizedBox(height: screenSize.height / 4.0),
//                  _buildProfileImage(),
//                  _buildFullName(),
//                  _buildStatus(context),
//                  //_buildStatContainer(),
//                  _buildBio(context),
//                  _buildSeparator(screenSize),
//                  SizedBox(height: 10.0),
//                  //_buildGetInTouch(context),
//                  SizedBox(height: 8.0),
//                  //_buildButtons(),
//                ],
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }

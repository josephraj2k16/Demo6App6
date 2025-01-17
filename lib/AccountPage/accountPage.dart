import 'package:MediAssist/Screens/Home/index.dart';
import 'package:MediAssist/Screens/Login/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class AccountPage extends StatefulWidget{
  AccountPage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
    AccountPage1 createState() => new AccountPage1();
}

class AccountPage1 extends State<AccountPage> {
  String _userId="";
  String _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
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
  String getBio(){
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
  }
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
   String _status = "PCP:Emma Brown";
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

  Widget _buildProfileImage() {

    String image1 = getImage();
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
  }



  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          fontFamily: 'Raleway',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
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

  Widget _buildBio(BuildContext context) {

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
    Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      title: "User Profile",
      debugShowCheckedModeBanner: false,
      //
      home:// UserProfilePage(),

      new Scaffold(
        appBar:new  AppBar(
          title: Text("My Account"),

          leading: InkWell(
            //onTap:  ()=>{null},
            onTap:() => Navigator.pop(context, false),
            child: Icon(Icons.arrow_back,),
          ),

        ),
        body: Stack(
          children: <Widget>[
            _buildCoverImage(screenSize),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: screenSize.height / 4.0),
                    _buildProfileImage(),
                    _buildFullName(),
                    _buildStatus(context),
                    //_buildStatContainer(),
                    _buildBio(context),
                    _buildSeparator(screenSize),
                    SizedBox(height: 10.0),
                    //_buildGetInTouch(context),
                    SizedBox(height: 8.0),
                    //_buildButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  Widget _buildGetInTouch(BuildContext context) {
//    return Container(
//      color: Theme.of(context).scaffoldBackgroundColor,
//      padding: EdgeInsets.only(top: 8.0),
//      child: Text(
//        "Get in Touch with ${_fullName.split(" ")[0]},",
//        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
//      ),
//    );
//  }

  Widget _buildButtons() {
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
  }

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



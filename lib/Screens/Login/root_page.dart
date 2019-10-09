import 'package:MediAssist/Screens/Home/index.dart';
import 'package:MediAssist/main1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:MediAssist/Screens/Login/login_signup_page.dart';
import 'package:MediAssist/Screens/Login/authentication.dart';
import 'package:MediAssist/Screens/Login/home_page.dart';


class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  String _email ="";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.email;
        }
        authStatus =
        user?.email == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user){
      setState(() {
        _userId = user.email.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;

    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignUpPage(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          if(_userId.compareTo("emma.brown@gmail.com")==0){
            return new DoctorPage(
              userId: _userId,
              auth: widget.auth,
              //email: _email,
              onSignedOut: _onSignedOut,
            );
          }else{


            return new HomeScreen(
              userId: _userId,
              auth: widget.auth,
              //email: _email,
              onSignedOut: _onSignedOut,
            );
          }} else return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }
}

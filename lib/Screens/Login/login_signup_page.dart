import 'package:MediAssist/Screens/Home/index.dart';
import 'package:MediAssist/Screens/Login/root_page.dart';
import 'package:MediAssist/Screens/Login/styles.dart';
import 'package:flutter/material.dart';
import 'package:MediAssist/Screens/Login/authentication.dart';

import 'styles.dart';
import 'dart:io';
import 'loginAnimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:MediAssist/Utils/database_helper.dart';
import 'package:MediAssist/Models/account.dart';
import 'package:sqflite/sqflite.dart';
import '../../Components/SignUpLink.dart';
import '../../Components/Form.dart';
import 'package:MediAssist/Utils/login_response.dart';
import 'package:MediAssist/Models/user.dart';
import '../../Components/SignInButton.dart';
import '../../Components/WhiteTick.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _errorMessage;
  var animationStatus = 0;

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId != null && userId.length > 0 && _formMode == FormMode.LOGIN) {
          widget.onSignedIn();
        }

      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }
String str(){
    return _email;
}

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Are you sure?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () =>
            //Navigator.pushReplacementNamed(context, "/login"),
            dispose(),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }
  Future<bool> _alert1() {
    return showDialog(
      context: context,
      child: new AlertDialog(
        title: new Text('Invalid UserName or Password'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('OK'),
          ),
          new FlatButton(
            onPressed: () =>
                Navigator.of(context).pushNamed("/login"),
            child: new Text('Exit'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
          body: new Container(
              decoration: new BoxDecoration(
                image: backgroundImage,
              ),
              child: new Container(
                  child: new ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: <Widget>[
                      new Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                             new Tick(image: tick),
                                _showBody(),
                              //new FormContainer(formkey),
                              _showCircularProgress(),
                             // new SignUp()
                            ],
                          ),
//                          animationStatus == 0
//                              ? new Padding(
//                            padding: const EdgeInsets.only(bottom: 50.0),
//                            child: new InkWell(
//                                onTap: ()   {
////                                        int st = await performLogin(username,password);
////                                        debugPrint("Status: "+'$st');
////                                        st==0?debugPrint("Login Not success"):debugPrint("Performed Login success");
//                                  setState(()  {
//                                    final bool v = formkey.currentState.validate();
//                                    if (v) {
//                                      _submit();
//                                      formkey.currentState.save();
//                                      print('Saved!!!');
//                                      //animationStatus = 1;
//                                    }
//
//                                  });
//                                  _playAnimation();
//                                },
//                                child: new SignIn()),
//                          )
//                              : new StaggerAnimation(
//                              buttonController:
//                              _loginButtonController.view),
//                        ],
              ]
                      ),
                    ],
                  ))),
        )));


//    return new Scaffold(
////        appBar: new AppBar(
////          title: new Text('Flutter login demo'),
////        ),
//
//        body: Stack(
//          children: <Widget>[
//              new Container(
//                decoration: new BoxDecoration(
//                     image: backgroundImage,
//                )),
//            _showBody(),
//            _showCircularProgress(),
//          ],
//        ));
  }

  Widget _showCircularProgress(){
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } return Container(height: 0.0, width: 0.0,);

  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showBody(){
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              //_showLogo(),
              _showEmailInput(),
              _showPasswordInput(),
              _showPrimaryButton(),
              _showSecondaryButton(),
              _showErrorMessage(),
            ],
          ),
        ));
  }

  Widget _showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

/*
  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: FlutterLogo(size: 100.0),
    );
  }
*/

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          icon: new Icon(
            Icons.person_outline,
            color: Colors.black,
          ),
          border: UnderlineInputBorder(),

          //hintText: "Username",
          labelText: 'User Name*',
          labelStyle:  const TextStyle(
              color: Colors.black, fontSize: 25.0) ,
//                        hintStyle: const TextStyle(
//                            color: Colors.black, fontSize: 25.0),
          contentPadding: const EdgeInsets.only(
              top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
           /* hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )*/),
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              _isLoading = false;
            });
            return 'Email can\'t be empty';
          }
        },
        onSaved: (value) =>{
          _email = value,
          //jo._email=value;
        }
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          icon: new Icon(
            Icons.lock_outline,
            color: Colors.black,
          ),
          border:  UnderlineInputBorder(

          ),

          //hintText: "Password",
          labelText: 'Password*',
          labelStyle:  const TextStyle(
              color: Colors.black, fontSize: 25.0) ,
//                        hintStyle: const TextStyle(
//                            color: Colors.black, fontSize: 25.0),
          contentPadding: const EdgeInsets.only(
              top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
            /*hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )*/
        ),
        validator: (value) {
          if (value.isEmpty) {
            setState(() {
              _isLoading = false;
            });
            return 'Email can\'t be empty';
          }
        },
        onSaved: (value) => _password = value,
      ),
    );
  }


  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
              style:
                  new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: _formMode == FormMode.LOGIN
                ? new Text('Login',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('Create account',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }
}

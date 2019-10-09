import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget{
  final GlobalKey<ScaffoldState> scaffoldKey;
  LoginScreen(this.scaffoldKey);
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState(scaffoldKey);
  }
}

class LoginScreenState extends State<LoginScreen>{
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey;

  LoginScreenState(this.scaffoldKey);

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      margin: EdgeInsets.all(40.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(),
            passwordField(),
            Container(margin: EdgeInsets.only(bottom: 25.0),),
            submitButton(),
          ],
        ),
      ),
    ),);
  }

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(hintText: 'ali@gmail.co', labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String value) {
        if(value=='admin'){
          debugPrint("username match");
        }
        _email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(hintText: '*****', labelText: 'Password'),
      onSaved: (String value) {
        if(value=='admin'){
          debugPrint("pass match");
        }
        _password = value;
      },
    );
  }

  Widget submitButton() {
    return RaisedButton.icon(
      color: Colors.cyan[900],
      textColor: Colors.white,
      label: Text('Submit'),
      icon: Icon(Icons.save),
      onPressed: () {
        final bool v = formKey.currentState.validate();
        if (v) {
          formKey.currentState.save();
          _performLogin();
          print('object');
        }
      },);
  }

  void _performLogin () {
    debugPrint('Email: $_email and Password $_password');
//    var snackbar = new SnackBar(
//      content: Text('Email: $_email and Password $_password'),
//    );
//    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
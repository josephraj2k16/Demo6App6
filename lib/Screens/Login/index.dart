  import 'package:flutter/material.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  LoginScreenState createState() => new LoginScreenState();

}

class LoginScreenState extends State<LoginScreen>with TickerProviderStateMixin implements LoginCallBack
     {
  String username;
  String password;
  BuildContext _ctx;
  bool _isLoading = false;
   String _username;
   String _password;
  LoginResponse _response;
  AnimationController _loginButtonController;
  final formkey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  var animationStatus = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();

  List<Account> acclist;
  int count = 0;
  bool status;
  // LoginScreenState(this._username,this._password);
  LoginScreenState(){
    _response = new LoginResponse(this);

  }
  void _submit() {
    final form = formkey.currentState;

    if (form.validate()) {
      debugPrint("inside _submit()");
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_username, _password);
      });
    }
  }
//  void _showSnackBar(String text) {
//    scaffoldKey.currentState.showSnackBar(new SnackBar(
//      content: new Text(text),
//    ));
//  }

  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Account>> accListFuture = databaseHelper.getAllAccounts();
      accListFuture.then((acountlist) {
        setState(() {
          this.acclist = acountlist;
          this.count = acountlist.length;
          debugPrint("Account-count "+'$count');
        });
      });
    });
  }
  Future checkingInsert() async {
    Account a = new Account("joseph","raj");
    int x = await databaseHelper.insertAccount(a);
    x==0?debugPrint("Not Inserted"):debugPrint("Inserted");
  }
  Future gettingAccount() async {
    List<Account> listcheck =await databaseHelper.getAllAccounts();
      for(Account i in listcheck){
        debugPrint("Account-name: "+i.accountame+" Pass: "+i.passWord);
      }
  }
  Future deletingOne(String name) async {
    int x = await databaseHelper.deleteNote(name);
    x==0?debugPrint("Not deleted"):debugPrint("deleted");
  }

  Future<int> performLogin(String username,String pass) async {
    int status=0;
    List<Account> listcheck =await databaseHelper.getAllAccounts();
    debugPrint("username came: "+username+" pass : "+pass);
    for(Account i in listcheck){
      //debugPrint("inside perform login1 Account-name: "+username+" Pass: "+pass);
//      if(i.passWord.compareTo(pass)==0){
//        debugPrint("Matching");
//      }else debugPrint("Not Matching");
      if(i.accountame.compareTo(username)==0&&i.passWord.compareTo(pass)==0)
      status=status+1;
      else
        status=0;
    }
    debugPrint("Status inside performLogin: " + '$status');
    return status;
  }
//  int doLogin(String us,String pas)  {
//    var i=0;
//    debugPrint("doLogin user id: "+us+" pass: "+pas);
//    Future<int> j= performLogin(us,pas);
//    j==1?i=1:i= 0;
//    debugPrint("Status inside doLogin: $i");
//    return i;
//  }


  @override
   initState()  {
    super.initState();
    //List<Account> listcheck =await databaseHelper.getAllAccounts();
//     updateListView();
     //checkingInsert();//important LIne!!!!!
//      deletingOne(" ");
     // gettingAccount();
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  Future dispose() async {
    _loginButtonController.dispose();
    int x = await databaseHelper.deleteDb();
    print("Deleting DB status: $x");
    super.dispose();
    exit(0);
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
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

    if (acclist == null) {
      acclist = List<Account>();
      updateListView();
    }

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
//                  decoration: new BoxDecoration(
//                      gradient: new LinearGradient(
//                    colors: <Color>[
//                      const Color.fromRGBO(162, 146, 199, 0.0),
//                      const Color.fromRGBO(51, 51, 63, 0.0),
//                    ],
//                    stops: [0.2,1.0],
//                    begin: const FractionalOffset(0.0, 0.0),
//                    end: const FractionalOffset(0.0, 1.0),
//                  )),
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
                              bodyPart(),
                              //new FormContainer(formkey),
                              new SignUp()
                            ],
                          ),
                          animationStatus == 0
                              ? new Padding(
                                  padding: const EdgeInsets.only(bottom: 50.0),
                                  child: new InkWell(
                                      onTap: ()   {
//                                        int st = await performLogin(username,password);
//                                        debugPrint("Status: "+'$st');
//                                        st==0?debugPrint("Login Not success"):debugPrint("Performed Login success");
                                        setState(()  {
                                          final bool v = formkey.currentState.validate();
                                          if (v) {
                                            _submit();
                                            formkey.currentState.save();
                                            print('Saved!!!');
                                            //animationStatus = 1;
                                          }

                                        });
                                        _playAnimation();
                                      },
                                      child: new SignIn()),
                                )
                              : new StaggerAnimation(
                                  buttonController:
                                      _loginButtonController.view),
                        ],
                      ),
                    ],
                  ))),
        )));
  }
  Widget bodyPart(){
    Account acc;

    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
              key: formkey,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(

//        border: new Border(
//          left:new BorderSide(width: 1.5,
//            color: Colors.indigoAccent,),
//          right:new BorderSide(width: 1.5,
//            color: Colors.indigoAccent,),
//          top: new BorderSide(width: 1.5,
//            color: Colors.indigoAccent,),
//          bottom: new BorderSide(
//            width: 1.5,
//            color: Colors.indigoAccent,
//          ),
//        ),
                    ),

                    child: new TextFormField(

                      keyboardType: TextInputType.text,
                      obscureText: false,
                      validator: (val) => val.length == 0 ? "Enter username" : null,
                      onSaved: (String val) {
                        debugPrint("Inside Username field:"+val);
                        _username=val;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                        icon: new Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                        border: UnderlineInputBorder(),

                        //hintText: "Username",
                        labelText: 'User Name*',
                        labelStyle:  const TextStyle(
                            color: Colors.black, fontSize: 25.0,) ,//fontWeight: FontWeight.bold
//                        hintStyle: const TextStyle(
//                            color: Colors.black, fontSize: 25.0),
                        contentPadding: const EdgeInsets.only(
                            top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
                      ),
                    ),
                  ),

                  new Container(
                    decoration: new BoxDecoration(
//        border: new Border(
//          bottom: new BorderSide(
//            width: 1.5,
//            color: Colors.indigo,
//          ),
//        ),
                    ),

                    child: new TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      validator: (val) => val.length == 0 ? "Enter password" : null,
                      onSaved: (val)   {
                        debugPrint("Inside password field:"+val);
                        _password = val;
//                        int st = await performLogin(username,password);
//                        debugPrint("Status: "+'$st');
//                        st==0?debugPrint("Login Not success"):debugPrint("Performed Login success");

                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
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
                      ),
                    ),
                  ),
//              new InputFieldArea(
//                hint: "Username",
//                obscure: false,
//                icon: Icons.person_outline,
//              ),
//              new InputFieldArea(
//                hint: "Password",
//                obscure: true,
//                icon: Icons.lock_outline,
//              ),
                ],
              )),
        ],
      ),
    ));

  }

@override
void onLoginError(String error) {
  // TODO: implement onLoginError
  //_showSnackBar(error);
  debugPrint("inside login Error method");

  Navigator.of(context).pushNamed("/login");
  _alert1();
    _isLoading = false;
}

@override
void onLoginSuccess(Account acc) async {

  if(acc != null){
      animationStatus=1;
      _playAnimation();
      await new Future.delayed(const Duration(seconds: 3));
      debugPrint("inside Login Succes meethod");
      Navigator.of(context).pushNamed("/home");

  }else{
      print("inside else ");
      onLoginError("Invalid Username or Password");
      _isLoading = false;
  }

}
}

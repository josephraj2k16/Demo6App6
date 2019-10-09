import 'package:flutter/material.dart';
import './InputFields.dart';
import 'package:MediAssist/Utils/database_helper.dart';
import 'package:MediAssist/Models/account.dart';
import 'package:sqflite/sqflite.dart';

class FormContainer extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> key1;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Account> acclist;
  int count = 0;
  Account acc;

  FormContainer(this.key1);

   String accountname='';
   String password='';
   bool status=false;

  Future<bool> performLogin(Account acc) async {
    List<Account> listcheck =await databaseHelper.getAllAccounts();
    for(Account i in listcheck){

      debugPrint("Account-name: "+i.accountame+" Pass: "+i.passWord);
      i.accountame==acc.accountame&&i.passWord==acc.passWord? status=true:status=false;
    }
    return status;
  }
  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal: 20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
              key: key1,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
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
                      validator: (val) => val.length == 0 ? "Enter username" : null,
                      onSaved: (String val) {
                        debugPrint("Inside Username field:"+val);
                        acc.accoutname=val;
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                        icon: new Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        hintText: "Username",
                        hintStyle: const TextStyle(
                            color: Colors.black, fontSize: 25.0),
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
                      onSaved: (val) async {
                        debugPrint("Inside password field:"+val);
                        acc.password = val;
                        bool st = await performLogin(acc);
                        bool==false?key1.currentState.reset():key1.currentState.save();
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                        icon: new Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            color: Colors.black, fontSize: 25.0),
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
}

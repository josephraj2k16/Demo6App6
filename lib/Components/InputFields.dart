import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
 // final String accountname;
  final Key k;
  String msg;

  //String password;
  InputFieldArea({this.hint, this.obscure, this.icon,this.k});
  @override
  Widget build(BuildContext context) {

    return (new Container(
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
        obscureText: obscure,
        validator: (val) => val.length == 0 ? "Enter Name" : null,
        onSaved: (val) => msg = val,

        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: new InputDecoration(
          icon: new Icon(
            icon,
            color:  Colors.black,
          ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color:  Colors.black, fontSize: 25.0),
          contentPadding: const EdgeInsets.only(
              top: 30.0, right: 30.0, bottom: 30.0, left: 5.0),
        ),
      ),
    ));
  }
}

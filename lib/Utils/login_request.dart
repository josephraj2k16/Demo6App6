import 'dart:async';

import 'package:MediAssist/Models/account.dart';
import 'package:MediAssist/Utils/database_helper.dart';

class LoginRequest {
  DatabaseHelper con = new DatabaseHelper();

  Future<Account> getLogin(String username, String password) async  {
    //con.initializeDatabase();
    var result = await con.getLogin(username,password);
    print("inside getLogin of login_req username: "+username+"pass: "+password+"result: $result");
    return result;
  }
}
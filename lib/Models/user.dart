class User{
  String _accountname;
  String _password;

  User(this._accountname,this._password);
  User.withName(this._accountname,this._password);

  String get accountame => _accountname;

  String get passWord => _password;

  set accoutname(String name){
    this._accountname=name;
  }

  set password(String pass){
    this._password=pass;
  }
  // convert Account to map
  Map<String, dynamic> toMap(){
    var map = Map<String,dynamic>();

    map['accountname'] = _accountname;
    map['password'] = _password;

    return map;

  }
  //convert map into account

  User.fromMapObject(Map<String,dynamic> map){
    this._accountname= map['accountname'];
    this._password= map['password'];
  }

}
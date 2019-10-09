import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var size;
List<DocumentSnapshot> snapshot1;
FutureOr<dynamic> snap;
//bool re = false;
var re;
var x;
//bool tt= false;
//var as="";
List<int> s1 = [0];
class StepProgressView_selectedDay extends StatefulWidget {


  //height of the container
  final double _height;

//width of the container
  final double _width;

  final String title;

  final DateTime selectedDay;

  final String drugId;

//container decoration
  final BoxDecoration decoration;

//list of texts to be shown for each step
  final List<dynamic> _stepsText;

  final List<dynamic> _stepsValue;

//cur step identifier
  final DateTime _curStep;

//active color
  final Color _activeColor;

//in-active color
  final Color _inactiveColor;

//dot radius
  final double _dotRadius;

//container padding
  final EdgeInsets padding;

//line height
  final double lineHeight;

//header textstyle
  final TextStyle _headerStyle;

//steps text
  final TextStyle _stepStyle;

  final int numberOfDots;

  const StepProgressView_selectedDay(
      String title,
      DateTime selectedDay,
      String drugId,
      List<dynamic> stepsText,
      List<dynamic> stepsValue,
      DateTime curStep,
      double height,
      double width,
      double dotRadius,
      Color activeColor,
      Color inactiveColor,
      TextStyle headerStyle,
      TextStyle stepsStyle, {
        Key key,
        this.decoration,
        this.padding,
        this.lineHeight = 2.0,
        this.numberOfDots = 3,
      })  : _stepsText = stepsText,
        _stepsValue=stepsValue,
        title = title,
        _curStep = curStep,
        selectedDay = selectedDay,
        drugId = drugId,
        _height = height,
        _width = width,
        _dotRadius = dotRadius,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _headerStyle = headerStyle,
        _stepStyle = stepsStyle,
  // assert(curStep >= 0 == true ),//&& curStep <= stepsText.length
        assert(width > 0),
        assert(height >= 2 * dotRadius),
        assert(width >= dotRadius * 2 * stepsText.length),
        super(key: key);


  @override
  StepProgressView_selectedDayState createState() => StepProgressView_selectedDayState();
}
class StepProgressView_selectedDayState extends State<StepProgressView_selectedDay> {
 /* //height of the container
  final double _height;

//width of the container
  final double _width;

  final String title;

  final DateTime selectedDay;

  final String drugId;

//container decoration
  final BoxDecoration decoration;

//list of texts to be shown for each step
  final List<dynamic> _stepsText;

//cur step identifier
  final DateTime _curStep;

//active color
  final Color _activeColor;

//in-active color
  final Color _inactiveColor;

//dot radius
  final double _dotRadius;

//container padding
  final EdgeInsets padding;

//line height
  final double lineHeight;

//header textstyle
  final TextStyle _headerStyle;

//steps text
  final TextStyle _stepStyle;

  final int numberOfDots;*/
 /* const StepProgressView_selectedDayState(
    String title,
    DateTime selectedDay,
    String drugId,
    List<dynamic> stepsText,
    DateTime curStep,
    double height,
    double width,
    double dotRadius,
    Color activeColor,
    Color inactiveColor,
    TextStyle headerStyle,
    TextStyle stepsStyle, {
    Key key,
    this.decoration,
    this.padding,
    this.lineHeight = 2.0,
    this.numberOfDots = 3,
  })  : _stepsText = stepsText,
        title = title,
        _curStep = curStep,
        selectedDay = selectedDay,
        drugId = drugId,
        _height = height,
        _width = width,
        _dotRadius = dotRadius,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _headerStyle = headerStyle,
        _stepStyle = stepsStyle,
        // assert(curStep >= 0 == true ),//&& curStep <= stepsText.length
        assert(width > 0),
        assert(height >= 2 * dotRadius),
        assert(width >= dotRadius * 2 * stepsText.length),
        super(key: key);*/
  bool retreat=false;
  _buildScheduledItems(String s){
   // print("SS VALUE---"+s);
    return Expanded(
      child: FavoriteWidget(
          s, widget.title, widget.selectedDay, widget.drugId, retreat),
    );
  }
  List<Widget> _buildText() {
    var wids = <Widget>[];
    widget._stepsText.asMap().forEach((i, text) {
      wids.add(Text(text, style: widget._stepStyle));
    });

    return wids;
  }
  List<Widget> _buildTimeTaken() {
    var wids = <Widget>[];
    widget._stepsText.asMap().forEach((i, text) {
      var formatter1 = new DateFormat('yyyy-MM-dd');
      String formatted1 = formatter1.format(widget.selectedDay);
      wids.add(StreamBuilder(
        stream:Firestore.instance
            .collection("Prescriptions")
            .document("Intakes")
            .collection(formatted1)
            .document(widget.drugId)
            .collection(text).document(text)
            .snapshots(),
        initialData: s1.first,
        builder: (context,snap1){
          //print("status--- "+snap1.data["switch"].toString());

          return Column(
            children: <Widget>[

              Row(
                  children:<Widget>[
                    Text(snap1.data["time_taken"], style: widget._stepStyle) ,
                  ]
              ),
            ],
          );
          //
        },

      )

      );
    });

    return wids;
  }
  List<Widget> _buildDots() {
    var wids = <Widget>[];
    widget._stepsText.asMap().forEach((i, text) {
      var formatter1 = new DateFormat('yyyy-MM-dd');
      String formatted1 = formatter1.format(widget.selectedDay);

     /* var re1;
      Firestore.instance
          .collection("Prescriptions")
          .document("Intakes")
          .collection(formatted1)
          .document(widget.drugId)
          .collection(text).where("switch", isEqualTo: false)
          .snapshots().listen((dataSnapshot) {
        snapshot1 = dataSnapshot.documents;
      }); //.getDocuments();

      if (snapshot1.isEmpty) {
        setState(() {
          retreat = true;
          wids.add(Container(
            child: FavoriteWidget(
                text, widget.title, widget.selectedDay, widget.drugId, retreat),
          ));
          //print("Inside IF");
        });
      }
      else {
        setState(() {
          retreat = false;

          //print("Inside ELSE");
        });
      }*/
      wids.add(StreamBuilder(
        stream:Firestore.instance
            .collection("Prescriptions")
            .document("Intakes")
            .collection(formatted1)
            .document(widget.drugId)
            .collection(text).document(text)
            .snapshots(),
        initialData: s1.first,
        builder: (context,snap1){
          //print("status--- "+snap1.data["switch"].toString());

          return Column(
            children: <Widget>[
              /*Row(
                 children:<Widget>[
                    Text(snap1.data["time_taken"], style: widget._stepStyle) ,
                ]
              ),*/

              Row(
                children: <Widget>[
                  FavoriteWidget(text,
                      widget.title,
                      widget.selectedDay,
                      widget.drugId,
                      snap1.data["switch"]==true?true:false),

          ],
          ),
            ],
          );
            //
        },

            )

         /* Container(
        child: FavoriteWidget(
            text, widget.title, widget.selectedDay, widget.drugId, retreat),
      )*/
      );
      /* a.listen((snap) {
        print("StepText----" + text);
        re1 = snap.documents[0].data;
        re = re1["switch"];
        print("SWITCH____$re");
      });*/
      if (i != widget._stepsText.length - 1) {
        wids.add(Expanded(
          child: Container(
            child: CustomPaint(
                painter: Drawhorizontalline()), // To get dotted line
          ),
        ));
      }
    });

    return wids;
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        padding: widget.padding,
        height: this.widget._height,
        width: this.widget._width,
        decoration: this.widget.decoration,
        child: Column(
          children: <Widget>[
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildTimeTaken(),
            ),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [tt? Text(x.toString()) :Text(" "),],
            ),*/
            SizedBox(
              height: 10,
            ),
            Row(
              children:
                _buildDots()
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildText(),
            )
          ],
        ));
  }
}

class Drawhorizontalline extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..strokeWidth = 1.5;
    var max = 100;
    var dashWidth = 6;
    var dashSpace = 6;
    double startY = 0;
    while (max >= 0) {
      //  canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      canvas.drawLine(Offset(startY, 0), Offset(startY + dashWidth, 0), paint);
      final space = (dashSpace + dashWidth);
      startY += space;
      max -= space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// this is to enable and disable icon
class FavoriteWidget extends StatefulWidget {
  FavoriteWidget(
      this.stepText, this.title1, this.selectedDay, this.drugId,this.retreat1);

  final String stepText;
  final String title1;
  final DateTime selectedDay;
  final String drugId;
  bool retreat1;


  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  bool ree = false;
  String step = "";


  @override
  Widget build(BuildContext context) {
    bool king = false;
    _isFavorited=widget.retreat1;
    //print("isFavourited value--new--"+widget.retreat1.toString());
    DateTime now1 = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(widget.selectedDay);
    return mainPart();
//    DateTime now = DateTime.now();
//    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    //here comes the column
  }

  Widget mainPart(){
    var newPart;
    int newPart1;
    var re1;
    var formatter1 = new DateFormat('yyyy-MM-dd');
    String formatted1 = formatter1.format(widget.selectedDay);
    var a = Firestore.instance
        .collection("Prescriptions")
        .document("Intakes")
        .collection(formatted1)
        .document(widget.drugId)
        .collection(widget.stepText)
        .snapshots(); //.getDocuments();
    a.listen((snap) {
      re1 = snap.documents[0].data;
      re = re1["time_taken"];
    });
    DateTime now1 = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(widget.selectedDay);
    String formatted_now1 = formatter.format(now1);
    if(widget.selectedDay.isAfter(now1)){
      return Column(
        children: [
          Container(
              child: IconButton(icon: Icon(Icons.healing), onPressed: null)
          ),
        ],
      );
    }else if(formatted == formatted_now1){
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*(widget.selectedDay.isAfter(now1))
              ? Container(
              padding: EdgeInsets.all(0),
              child: IconButton(icon: Icon(Icons.healing), onPressed: null))
              :*/
          Container(
            padding: EdgeInsets.all(0),
            child: IconButton(
                icon: (_isFavorited//(re.toString()!="0") //==_isFavorited
                    ? Icon(Icons.healing, color: Colors.green)
                    : Icon(Icons.healing, color: Colors.black)),
                onPressed: () {
                  // print("STEPTEXT___"+widget.stepText);
                  //_isFavorited=getSwitch(widget.stepText);
                  DateTime nowTime = DateTime.now();
                  var x = DateFormat('kk:mm').format(
                      nowTime); //TimeOfDay.fromDateTime(DateTime.now());
                  setState(() {
                    if (_isFavorited) { //re.toString()=="0"
                      _isFavorited=false;
                      Firestore.instance
                          .collection("Prescriptions")
                          .document("Intakes")
                          .collection(formatted)
                          .document(widget.drugId)
                          .collection(widget.stepText)
                          .document(widget.stepText)
                          .updateData({'switch': false,'time_taken' : ""}).then((result) {
                        // print("Success inside now--------");
                      }).catchError((e) {
                        // print(e);
                      });
                      var x=Firestore.instance
                          .collection("Prescriptions")
                          .document("Intakes")
                          .collection(formatted).where("drug_id",isEqualTo: widget.drugId)
                          .getDocuments();
                      x.then((d){
                        newPart=d.documents[0].data;
                        setState(() {
                          newPart1=newPart["counter_actual"]-1;
                          Firestore.instance
                              .collection("Prescriptions")
                              .document("Intakes")
                              .collection(formatted)
                              .document(widget.drugId)
                              .updateData({
                            'counter_actual':newPart1
                          }).then((result) {
                            //print("Success--------");
                          }).catchError((e) {
                            // print(e);
                          });
                        });
                      });
                    } else {

                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            DateTime now = DateTime.now();
                            return Container(
                              child: new Wrap(
                                children: <Widget>[
                                  new ListTile(
                                      leading: new Icon(Icons.access_time),
                                      title:
                                      new Text('Choose Correct Time'),
                                      onTap: () {
                                        _isFavorited=true;
                                        showTimePicker(
                                          context: bc,
                                          initialTime: TimeOfDay(
                                              hour: now.hour,
                                              minute: now.minute),
                                          builder: (BuildContext context,
                                              Widget child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                  alwaysUse24HourFormat:
                                                  true),
                                              child: child,
                                            );
                                          },
                                        ).then<TimeOfDay>(
                                                (TimeOfDay value) {
                                              var x1 = value
                                                  .toString()
                                                  .substring(10, 15);
                                              //  print("time picker: $x1");
                                              Firestore.instance
                                                  .collection("Prescriptions")
                                                  .document("Intakes")
                                                  .collection(formatted)
                                                  .document(widget.drugId)
                                                  .collection(widget.stepText)
                                                  .document(widget.stepText)
                                                  .updateData({
                                                'switch':true,
                                                'time_taken': x1
                                              }).then((result) {
                                                //  print("Success--------");
                                              }).catchError((e) {
                                                //  print(e);
                                              });
                                              var x=Firestore.instance
                                                  .collection("Prescriptions")
                                                  .document("Intakes")
                                                  .collection(formatted).where("drug_id",isEqualTo: widget.drugId)
                                                  .getDocuments();
                                              x.then((d){
                                                newPart=d.documents[0].data;
                                                setState(() {
                                                  newPart1=newPart["counter_actual"]+1;
                                                  Firestore.instance
                                                      .collection("Prescriptions")
                                                      .document("Intakes")
                                                      .collection(formatted)
                                                      .document(widget.drugId)
                                                      .updateData({
                                                    'counter_actual':newPart1
                                                  }).then((result) {
                                                    //  print("Success--------");
                                                  }).catchError((e) {
                                                    //  print(e);
                                                  });
                                                });
                                              });
                                              /*if (value != null) {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    '${value.format(context)}'),
                                                action: SnackBarAction(
                                                    label: 'Ok',
                                                    onPressed: () {}),
                                              ));
                                            }*/
                                              Navigator.pop(context);
                                            });
                                      }),
                                  new ListTile(
                                    leading: new Icon(Icons.timeline),
                                    title: new Text(
                                        'Now(' + x.toString() + ')'),
                                    onTap: () {
                                      _isFavorited=true;
                                      Firestore.instance
                                          .collection("Prescriptions")
                                          .document("Intakes")
                                          .collection(formatted)
                                          .document(widget.drugId)
                                          .collection(widget.stepText)
                                          .document(widget.stepText)
                                          .updateData({
                                        'time_taken': x.toString(),
                                        'switch': true
                                      }).then((result) {
                                        //print("Success inside now--------");
                                      }).catchError((e) {
                                        // print(e);
                                      });
                                      var xy=Firestore.instance
                                          .collection("Prescriptions")
                                          .document("Intakes")
                                          .collection(formatted).where("drug_id",isEqualTo: widget.drugId)
                                          .getDocuments();
                                      xy.then((d){
                                        newPart=d.documents[0].data;
                                        setState(() {
                                          newPart1=newPart["counter_actual"]+1;
                                          Firestore.instance
                                              .collection("Prescriptions")
                                              .document("Intakes")
                                              .collection(formatted)
                                              .document(widget.drugId)
                                              .updateData({
                                            'counter_actual':newPart1
                                          }).then((result) {
                                            //print("Success--------");
                                          }).catchError((e) {
                                            // print(e);
                                          });
                                        });
                                      });
                                      Navigator.pop(context);
                                      /*if(_isFavorited==ree){
                                Firestore.instance
                                    .collection("Prescriptions")
                                    .document(
                                    "Intakes")
                                    .collection(formatted)
                                    .document(widget.drugId)
                                    .collection(widget.stepText)
                                    .document(widget.stepText)
                                    .updateData({
                                  'switch': true
                                }).then((result) {
                                  print("Success inside now--------");
                                }).catchError((e) {
                                  print(e);
                                });
                              }else{

                              }*/
                                      //print("nowTime---------- : "+x.toString());
                                    },
                                  ),
                                ],
                              ),
                            );
                          }); //showmodalbottom
                    }
                  });

                  //if (_isFavorited == true) {

                  // } else {print("back againnnnnnnnnnnn");}
                }),
            /*  SizedBox(
            width: 18,
            child: Container(
             // child: Text(formattedDate),
            ),
          ),*/
          ),
        ],
      );
    }
    else{

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(0),
            child: IconButton(
                icon: (_isFavorited//(re.toString()!="0") //==_isFavorited
                    ? Icon(Icons.healing, color: Colors.green)
                    : Icon(Icons.healing, color: Colors.redAccent)),
                onPressed: () {
                  // print("STEPTEXT___"+widget.stepText);
                  //_isFavorited=getSwitch(widget.stepText);
                  DateTime nowTime = DateTime.now();
                  x = DateFormat('kk:mm').format(
                      nowTime); //TimeOfDay.fromDateTime(DateTime.now());
                  setState(() {
                    if (_isFavorited) { //re.toString()!="0"
                      //tt= false;
                      _isFavorited=false;
                      Firestore.instance
                          .collection("Prescriptions")
                          .document("Intakes")
                          .collection(formatted)
                          .document(widget.drugId)
                          .collection(widget.stepText)
                          .document(widget.stepText)
                          .updateData({'switch': false,'time_taken' : ""}).then((result) {
                        //print("Success inside now--------");
                      }).catchError((e) {
                        // print(e);
                      });
                      var x=Firestore.instance
                          .collection("Prescriptions")
                          .document("Intakes")
                          .collection(formatted).where("drug_id",isEqualTo: widget.drugId)
                          .getDocuments();
                      x.then((d){
                        newPart=d.documents[0].data;
                        setState(() {
                          if(newPart["counter_actual"]>=0){
                            newPart1=newPart["counter_actual"]-1;
                            Firestore.instance
                                .collection("Prescriptions")
                                .document("Intakes")
                                .collection(formatted)
                                .document(widget.drugId)
                                .updateData({
                              'counter_actual':newPart1
                            }).then((result) {
                              //print("Success--------");
                            }).catchError((e) {
                              // print(e);
                            });

                          }else{

                          }

                        });
                      });
                    } else {
                      _isFavorited=false;
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            DateTime now = DateTime.now();
                            return Container(
                              child: new Wrap(
                                children: <Widget>[
                                  new ListTile(
                                      leading: new Icon(Icons.access_time),
                                      title:
                                      new Text('Choose Correct Time'),
                                      onTap: () {
                                        _isFavorited=true;
                                        //tt=true;
                                        showTimePicker(
                                          context: bc,
                                          initialTime: TimeOfDay(
                                              hour: now.hour,
                                              minute: now.minute),
                                          builder: (BuildContext context,
                                              Widget child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                  alwaysUse24HourFormat:
                                                  true),
                                              child: child,
                                            );
                                          },
                                        ).then<TimeOfDay>(
                                                (TimeOfDay value) {
                                              var x1 = value
                                                  .toString()
                                                  .substring(10, 15);
                                              //print("time picker: $x1");
                                              Firestore.instance
                                                  .collection("Prescriptions")
                                                  .document("Intakes")
                                                  .collection(formatted)
                                                  .document(widget.drugId)
                                                  .collection(widget.stepText)
                                                  .document(widget.stepText)
                                                  .updateData({
                                                'switch':true,
                                                'time_taken': x1
                                              }).then((result) {
                                                // print("Success--------");
                                              }).catchError((e) {
                                                // print(e);
                                              });
                                              var x=Firestore.instance
                                                  .collection("Prescriptions")
                                                  .document("Intakes")
                                                  .collection(formatted).where("drug_id",isEqualTo: widget.drugId)
                                                  .getDocuments();
                                              x.then((d){
                                                newPart=d.documents[0].data;
                                                setState(() {
                                                  if(newPart["counter_actual"] < newPart["counter_ideal"]){
                                                    newPart1=newPart["counter_actual"]+1;
                                                    Firestore.instance
                                                        .collection("Prescriptions")
                                                        .document("Intakes")
                                                        .collection(formatted)
                                                        .document(widget.drugId)
                                                        .updateData({
                                                      'counter_actual':newPart1
                                                    }).then((result) {
                                                      // print("Success--------");
                                                    }).catchError((e) {
                                                      // print(e);
                                                    });
                                                  }
                                                  else{

                                                  }

                                                });
                                              });
                                              /*if (value != null) {
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    '${value.format(context)}'),
                                                action: SnackBarAction(
                                                    label: 'Ok',
                                                    onPressed: () {}),
                                              ));
                                            }*/
                                              Navigator.pop(context);
                                            });
                                      }),
                                  new ListTile(

                                    leading: new Icon(Icons.timeline),
                                    title: new Text(
                                        'Now(' + x.toString() + ')'),
                                    onTap: () {
                                      // tt= true;
                                      _isFavorited=true;
                                      Firestore.instance
                                          .collection("Prescriptions")
                                          .document("Intakes")
                                          .collection(formatted)
                                          .document(widget.drugId)
                                          .collection(widget.stepText)
                                          .document(widget.stepText)
                                          .updateData({
                                        'time_taken': x.toString(),
                                        'switch': true
                                      }).then((result) {
                                        // print("Success inside now--------");
                                      }).catchError((e) {
                                        // print(e);
                                      });
                                      var xy=Firestore.instance
                                          .collection("Prescriptions")
                                          .document("Intakes")
                                          .collection(formatted).where("drug_id",isEqualTo: widget.drugId)
                                          .getDocuments();
                                      xy.then((d){
                                        newPart=d.documents[0].data;
                                        setState(() {
                                          if(newPart["counter_actual"] < newPart["counter_ideal"]){
                                            newPart1=newPart["counter_actual"]+1;
                                            Firestore.instance
                                                .collection("Prescriptions")
                                                .document("Intakes")
                                                .collection(formatted)
                                                .document(widget.drugId)
                                                .updateData({
                                              'counter_actual':newPart1
                                            }).then((result) {
                                              //  print("Success--------");
                                            }).catchError((e) {
                                              // print(e);
                                            });
                                          }
                                          else{

                                          }

                                        });
                                      });
                                      Navigator.pop(context);
                                      /*if(_isFavorited==ree){
                                Firestore.instance
                                    .collection("Prescriptions")
                                    .document(
                                    "Intakes")
                                    .collection(formatted)
                                    .document(widget.drugId)
                                    .collection(widget.stepText)
                                    .document(widget.stepText)
                                    .updateData({
                                  'switch': true
                                }).then((result) {
                                  print("Success inside now--------");
                                }).catchError((e) {
                                  print(e);
                                });
                              }else{

                              }*/
                                      //print("nowTime---------- : "+x.toString());
                                    },
                                  ),
                                ],
                              ),
                            );
                          }); //showmodalbottom
                    }
                  });

                  //if (_isFavorited == true) {

                  // } else {print("back againnnnnnnnnnnn");}
                }),
            /*  SizedBox(
            width: 18,
            child: Container(
             // child: Text(formattedDate),
            ),
          ),*/
          ),
        ],
      );
    }


  }
}

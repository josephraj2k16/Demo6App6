import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StepProgressView extends StatelessWidget {
  //height of the container
  final double _height;

//width of the container
  final double _width;

  final String title;



//container decoration
  final BoxDecoration decoration;

//list of texts to be shown for each step
  final List<String> _stepsText;

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

  const StepProgressView(
      String title,

    List<String> stepsText,
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
         title=title,
        _curStep = curStep,

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

  List<Widget> _buildDots() {
    var wids = <Widget>[];
    _stepsText.asMap().forEach((i, text) {
      /*var lineColor = _curStep > i + 1
          ? _activeColor
          : _inactiveColor;*/
//      var circleColor = (_curStep > i + 1) //i == 0 ||
//          ? _activeColor
//          : _inactiveColor;

      /* wids.add(CircleAvatar(


       // radius: _dotRadius,
       */ /* backgroundColor: Colors.black,
      child: new Icon(Icons.healing,color: Colors.grey,)*/ /*

        ),*/
      wids.add(Expanded(
        //  CircleAvatar(
        // radius: _dotRadius,
        //child: Container(
        child: FavoriteWidget(text,title),
        //),
      )
          //    )
          );

      //add a line separator
      //0-------0--------0
      if (i != _stepsText.length - 1) {
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

  List<Widget> _buildText() {
    var wids = <Widget>[];
    _stepsText.asMap().forEach((i, text) {
      wids.add(Text(text, style: _stepStyle));
    });

    return wids;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: padding,
        height: this._height,
        width: this._width,
        decoration: this.decoration,
        child: Column(
          children: <Widget>[
            Container(
                child: Center(
                    child: RichText(
                        text: TextSpan(children: [
              TextSpan(
                // text: (_curStep).toString(),
                style: _headerStyle.copyWith(
                  color: _activeColor, //this is always going to be active
                ),
              ),
              /* TextSpan(
                                text: " * " + _stepsText.length.toString(),
                                style: _headerStyle.copyWith(
                                  color: _curStep == _stepsText.length
                                      ? _activeColor
                                      : _inactiveColor,
                                ),
                              ),*/
            ])))),
            Row(
              children: _buildDots(),
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
    var max = 80;
    var dashWidth = 5;
    var dashSpace = 5;
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
  FavoriteWidget(this.stepText,this.title1);

  final String stepText;
  final String title1;
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  String step = "";

  // String step1=

//  void fersy(String x){
//      if (text == "8.00-10.00AM" && !_isFavorited) {
//        Firestore.instance.collection("Intake_times").document(text).updateData(
//            {
//              'time_taken': x.toString()
//            }).then((result) {
//          print("Success--------");
//        }).catchError((e) {
//          print(e);
//        });
//      }
//      else if (text == "1.00-2.00PM" && !_isFavorited) {
//        Firestore.instance.collection("Intake_times").document(text).updateData(
//            {
//              'time_taken': x.toString()
//            }).then((result) {
//          print("Success--------");
//        }).catchError((e) {
//          print(e);
//        });
//      }
//      else {
//        Firestore.instance.collection("Intake_times").document(text).updateData(
//            {
//              'time_taken': x.toString()
//            }).then((result) {
//          print("Success--------");
//        }).catchError((e) {
//          print(e);
//        });
//      }
//
//
//      );
//  }

  /*TimeOfDay _toggleFavorite() {
    var x =TimeOfDay.fromDateTime(DateTime.now());
    print(x);
    setState(() {

      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
    return x;
  }*/

  String getTitle(String title){
    if(title=="Bimatoprost"){
      return "User1";
    }else if(title=="Injection Ranitidine 50mg/2ml"){
      return "User2";
    }else if(title=="Mupirocin Oinment"){
      return "User3";
    }else if(title=="Ascorbic acid 500mg"){
      return "User4";
    }else if(title=="Paracetamol 500mg"){
      return "tab5";
    }else if(title=="Enalapril 5mg"){
      return "tab6";
    }else if(title=="Ferrous Sulphate 325mg"){
      return "tab7";
    }else if(title=="Warfarin 2mg"){
      return "tab8";
    }

  }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
              icon: (_isFavorited
                  ? Icon(Icons.healing, color: Colors.black)
                  : Icon(Icons.healing, color: Colors.green)),
              // color: Colors.black,
              onPressed: () {
                var x = TimeOfDay.fromDateTime(DateTime.now());
                setState(() {
                  if (_isFavorited) {
                    _isFavorited = false;
                  } else {
                    _isFavorited = true;
                  }
                });

                if (_isFavorited == false) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              content: Text("Administered at "+x.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0)),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text('Ok',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0)),
                                    onPressed: () {
                                      Firestore.instance
                                          .collection("Prescriptions").document("Intakes")//getTitle(widget.title1)
                                            .collection("").document("Intake")
                                            .collection(widget.stepText)
                                          .document(widget.stepText)
                                          .updateData({
                                        'time_taken': x.toString()
                                      }).then((result) {
                                        print("Success--------");
                                      }).catchError((e) {
                                        print(e);
                                      });
                                      //print("gvshzjdf-----" + x.toString());
                                      Navigator.pop(context, 'Ok');
                                    }),
                              ]));
                } else {}
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

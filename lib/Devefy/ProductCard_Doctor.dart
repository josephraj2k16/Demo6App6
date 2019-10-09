import 'package:MediAssist/PatientPage.dart';
import 'package:flutter/material.dart';
import 'CustomIcon.dart';
import 'package:MediAssist/stepindicator.dart';

class ProductCard_Doctor extends StatelessWidget {
  int cardColor;
  String imgUrl;
  String title;
  String description;


  ProductCard_Doctor(
      this.cardColor, this.imgUrl, this.title, this.description);


  final _stepsText = ["8.00-10.00AM", "1.00-2.00PM", "8.00-9.00PM"];

  final _stepCircleRadius = 20.0;

  final _stepProgressViewHeight = 150.0;

  Color _activeColor = Colors.lightGreenAccent;

  Color _inactiveColor = Colors.black26;

  TextStyle _headerStyle =
  TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);

  Size _safeAreaSize;

  DateTime _curPage = DateTime.now();

  StepProgressView _getStepProgress() {
    return StepProgressView(
      title,
      _stepsText,
      _curPage,
      _stepProgressViewHeight,
      _safeAreaSize.width,
      _stepCircleRadius,
      _activeColor,
      _inactiveColor,
      _headerStyle,
      _stepStyle,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white),
      padding: EdgeInsets.only(
        top: 48.0,
        left: 24.0,
        right: 24.0,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var mediaQD = MediaQuery.of(context);
    _safeAreaSize = mediaQD.size;


    var exp = new Card(
        color: Colors.white,//Color(0xFFeee6ff),
        elevation: 10.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ) ,
      child: new ExpansionTile(
        leading: Image.asset(imgUrl),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title,
                style: TextStyle(color: Colors.black,fontSize: 18.5, fontFamily: "Helvetica")),
            Text(description,
                style: TextStyle(
                  //color: Color(0xFFfeb0ba),
                    color: Colors.black,
                    fontSize: 16.0,
                    fontFamily: "RalewayItalic")),
          ],

        ),
        /*children: <Widget>[
          _getStepProgress(),
        ],*/

    )

    );



    return Container(
        child: new InkWell(
            /*onTap: (){
              Navigator.push(context, new MaterialPageRoute(
                                        builder: (context) => new PatientPage(
                                              userId: _userId,
                                              auth: widget.auth,)
              )
              );
            },*/
            child:new SizedBox(
                  child: exp,

        ))
    );

  }
}


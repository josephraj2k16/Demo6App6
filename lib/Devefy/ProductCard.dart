import 'package:flutter/material.dart';
import 'CustomIcon.dart';
import 'package:MediAssist/stepindicator.dart';

class ProductCard extends StatelessWidget {
  int cardColor;
  String imgUrl;
  String title;
  String description;
  String refills;
  String lastApplied;
  String LastTaken;


  ProductCard(this.cardColor, this.imgUrl, this.title, this.description,
      this.refills, this.lastApplied);

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

 // DateTime _selectedDay = DateTime.now();

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
          borderRadius: BorderRadius.circular(15.0), color: Colors.white),
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

    String getApplienOnString(int medication) {
      switch (medication) {
        case 1:
          return "Last Applied On: ";
          break;
        case 2:
          return "Last Taken: ";
          break;

        default:
          return "Last Taken: ";
      }
    }

    var exp = new Card(
        color: Colors.white, //Color(0xFFeee6ff),
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: new ExpansionTile(
          leading: Image.asset(imgUrl),
          trailing: InkWell(
              child: Icon(
                Icons.warning,
                color: Colors.black54,
                size: 30.0,
              ),
              onTap: () {
                if (title == "Ferrous Sulphate 325mg") {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              // title: const Text("Warning"),
                              content: Text(
                                "Do not take Milk products 2 hours before / after intake of Ferrous sulphate - 325 mg. It decreases the iron absorption",
                                style: TextStyle(
                                    //color: Colors.lightGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                ),
                              ]));
                }
                else if (title == "Warfarin 2mg") {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              // title: const Text("Warning"),
                              content: Text(
                                "You should maintain a consistent level of consumption of these products. Foods rich in vitamin K include beef liver,"
                                "broccoli, Brussels sprouts, cabbage, collard greens, endive, kale, lettue, mustard greens, parsley, soy beans, spinach,"
                                "Swiss card, turnip greens, watercress, and other green leafy vegetables. Moderate to high levels of vitamin K are aalso"
                                "found in other foods such as asparagus, avocados, dill pickels, green peas, greeen tea,canola oil, margarine, mayonnaise,, olive oil,"
                                "soybean oil ",
                                style: TextStyle(
                                    //color: Colors.lightGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                ),
                              ]));
                } else {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              // title: const Text("Warning"),
                              content: Text(
                                "No Serious Food/Drug Interactions.",
                                style: TextStyle(
                                    //color: Colors.lightGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                ),
                              ]));
                }
              }
              ),
          /*trailing: IconButton(
          child: Icon(Icons.warning, color: Colors.black54,size: 40.0,),
        ),*/

          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.5,
                      fontFamily: "Helvetica")),
              Text(description,
                  style: TextStyle(
                      //color: Color(0xFFfeb0ba),
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: "RalewayItalic")),
              Text(
                "Refills Left: " + refills,
                style: TextStyle(color: Colors.black),
              ),
              Text(getApplienOnString(1) + lastApplied),
            ],
          ),
          children: <Widget>[
            _getStepProgress(),
          ],
        ));

    return Container(
        child: new SizedBox(
      child: exp,
    ));
//    return
//        Container(
//            //padding: EdgeInsets.only(right: 60.0),
//            width: 350.0, //double.infinity;
//            height: 320.0,
//            decoration: BoxDecoration(
//                  color: Color(cardColor),
//                  borderRadius: BorderRadius.circular(20.0),
//                  border: Border.all(color: Colors.grey.withOpacity(.3), width: .2)),
//
//          child: Column(
//            children: <Widget>[
//              SizedBox(
//            height: 7.0,
//          ),
//            Row(
//            //mainAxisSize: MainAxisSize.max,
//            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            //crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              Expanded(
//                child: Image.asset(imgUrl, width: 181.0, height: 100.0),
//              ),
//
//              Expanded(
//                child: Text(title,
//                    style: TextStyle(fontSize: 18.5, fontFamily: "Helvetica")),
//              )
//            ],
//          ),
//
////          Padding(padding: EdgeInsets.only(left: 30.0),),
////
////          Expanded(
////
////              child:Row(
////                children: <Widget>[
////
////            ],
////          )),
//
////          SizedBox(
////            height: 15.0,
////          ),
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 30.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                IconButton(
//                  icon: Icon(CustomIcons.favorite),
//                  onPressed: () {},
//                ),
//                Column(
//                  children: <Widget>[
//                    Text(description,
//                        style: TextStyle(
//                            //color: Color(0xFFfeb0ba),
//                            fontSize: 16.0,
//                            fontFamily: "RalewayItalic")),
//                    SizedBox(
//                      height: 12.0,
//                    ),
//                    Text(price,
//                        style:
//                            TextStyle(fontSize: 28.0, fontFamily: "Helvetica")),
//                  ],
//                ),
//                IconButton(
//                  icon: Icon(CustomIcons.cart),
//                  onPressed: () {},
//                )
//              ],
//            ),
//          )
//        ],
//      ),
//    );
  }
}

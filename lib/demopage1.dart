//import 'package:flutter/material.dart';
//import 'package:MediAssist/stepindicator.dart';
//
//class demopage1 extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return demostate1();
//  }
//}
//
//class demostate1 extends State<demopage1> {
//  ListView List_Criteria;
//
//  final _stepsText = ["About you", "Some more..", "Your credit card details"];
//
//  final _stepCircleRadius = 20.0;
//
//  final _stepProgressViewHeight = 150.0;
//
//  Color _activeColor = Colors.lightGreenAccent;
//
//  Color _inactiveColor = Colors.black26;
//
//  TextStyle _headerStyle =
//      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
//
//  TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);
//
//  Size _safeAreaSize;
//
//  DateTime _curPage = DateTime.now();
//
//  StepProgressView _getStepProgress() {
//    return StepProgressView(
//      _stepsText,
//      _curPage,
//      _stepProgressViewHeight,
//      _safeAreaSize.width,
//      _stepCircleRadius,
//      _activeColor,
//      _inactiveColor,
//      _headerStyle,
//      _stepStyle,
//      decoration: BoxDecoration(color: Colors.white),
//      padding: EdgeInsets.only(
//        top: 48.0,
//        left: 24.0,
//        right: 24.0,
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    var mediaQD = MediaQuery.of(context);
//    _safeAreaSize = mediaQD.size;
//    // TODO: implement build
//    return new Scaffold(
//        appBar: new AppBar(
//          title: new Text("MY Prescriptions"),
//        ),
//        body: Container(
//          margin: EdgeInsets.only(left: 20.0,top: 10.0),
//          width: 350.0,
//          height: 350.0,
//          decoration: BoxDecoration(
//              color: Color(0xFF8cff66),
//              borderRadius: BorderRadius.circular(20.0),
//              border: Border.all(color: Colors.grey.withOpacity(.3), width: .2)
//
//          ),
//          child: ListView(
//          children: [
//            new Padding(
//                padding: new EdgeInsets.all(10.0),
//                child: ExpansionTile(
//                  title: Text("Dolopar"),
//                  leading: new Icon(Icons.accessible_forward),
//                  children: <Widget>[
//                    _getStepProgress(),
//                  ],
//                )),
//          ],
//        ),),
//
//        );
////        new Container(
////          padding: new EdgeInsets.all(32.0),
////          child: new Center(
////            child: new Column(
////              children: <Widget>[
////                new Card(
////                  child: new Container(
////                    padding: new EdgeInsets.all(32.0),
////                    child: new Column(
////                      children: <Widget>[
////                        new Text('Hello World'),
////                        new Text('How are you?')
////                      ],
////                    ),
////                  ),
////                ),
////                new Card(
////                  child: new Container(
////                    padding: new EdgeInsets.all(32.0),
////                    child: new Column(
////                      children: <Widget>[
////                        new Text('Hello World'),
////                        new Text('How are you?')
////                      ],
////                    ),
////                  ),
////                ),
////                new Card(
////                  child: new Container(
////                    padding: new EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
////                    child: new Column(
////                      children: <Widget>[
////                        new Text('Hello World'),
////                        new Text('How are you?')
////                      ],
////                    ),
////                  ),
////                )
////              ],
////            ),
////          ),
////        ),
//
////
//  }
//}
//
////items.map((NewItem item) {
////return new ExpansionPanel(
////headerBuilder: (BuildContext context, bool isExpanded) {
////return new ListTile(
////leading: item.image,
////title: new Text(
////item.header,
////textAlign: TextAlign.left,
////style: new TextStyle(
////fontSize: 20.0,
////fontWeight: FontWeight.w400,
////),
////));
////},
////isExpanded: item.isExpanded,
////body: item.body,
////);
////}).toList(),

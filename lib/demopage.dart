//import 'package:flutter/material.dart';
//import 'package:MediAssist/stepindicator.dart';
//
//class demopage extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() {
//    return demopagestate();
//  }
//
//  }
//  class demopagestate extends State<demopage> {
//
//    final _stepsText = ["About you", "Some more..", "Your credit card details"];
//
//    final _stepCircleRadius = 20.0;
//
//    final _stepProgressViewHeight = 150.0;
//
//    Color _activeColor = Colors.lightGreenAccent;
//
//    Color _inactiveColor = Colors.black26;
//
//    TextStyle _headerStyle =
//    TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
//
//    TextStyle _stepStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold);
//
//    Size _safeAreaSize;
//
//    DateTime _curPage = DateTime.now();
//
//    StepProgressView _getStepProgress() {
//      return StepProgressView(
//        _stepsText,
//        _curPage,
//        _stepProgressViewHeight,
//        _safeAreaSize.width,
//        _stepCircleRadius,
//        _activeColor,
//        _inactiveColor,
//        _headerStyle,
//        _stepStyle,
//        decoration: BoxDecoration(color: Colors.white),
//        padding: EdgeInsets.only(
//          top: 48.0,
//          left: 24.0,
//          right: 24.0,
//        ),
//      );
//    }
//
//  @override
//  Widget build(BuildContext context) {
//    var mediaQD = MediaQuery.of(context);
//    _safeAreaSize = mediaQD.size;
//    return Scaffold(
//        body: Column(
//          children: <Widget>[
//            Container(height: 150.0, child: _getStepProgress()),
//            Expanded(
//              child: PageView(
//                onPageChanged: (i) {
//                  setState(() {
//                   // _curPage = i + 1;
//                  });
//                },
//                children: <Widget>[
////                  _step1(),
////                  _step2(),
////                  _step3(),
//                  Container(
//                    color: Colors.pink,
//                  ),
//                  Container(
//                    color: Colors.cyan,
//                  ),
//                  Container(
//                    color: Colors.deepPurple,
//                  ),
////                  Container(
////                    color: Colors.amber,
////                  ),
//                ],
//              ),
//            )
//          ],
//        ));
//  }
//
//  }
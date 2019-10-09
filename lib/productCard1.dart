import 'package:flutter/material.dart';
import 'package:MediAssist/stepindicator.dart';

class productCard1 extends StatelessWidget {
  int cardColor;
  String imgUrl;
  String title;
  String description;
//  String refills;
//  String lastApplied;
//  String LastTaken;

  productCard1(
      this.cardColor, this.imgUrl, this.title, this.description);

  final _stepsText = ["Morning", "Noon", "Night"];

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
      decoration: BoxDecoration(color: Colors.white),
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

    var card= new Card(
      color: Colors.white,//Color(0xFFeee6ff),
      elevation: 10.0,
      child: new Column(
        children: <Widget>[
          new ListTile(
            leading: Image.asset(imgUrl),
            title: Text(title,
                style: TextStyle(fontSize: 18.5, fontFamily: "Helvetica")),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(description,
                    style: TextStyle(
                      //color: Color(0xFFfeb0ba),
                        fontSize: 16.0,
                        fontFamily: "RalewayItalic")),
                //Text(""+refills,style: TextStyle(color: Colors.teal),),
                //Text(getApplienOnString(1)+lastApplied),
              ],
            ),



//            onTap: ()=>new AlertDialog(
//              title: Text("Alert"),
//            ),
          )
        ],
      ),
    );

    var exp = new Card(
        color: Colors.white,//Color(0xFFeee6ff),
        elevation: 10.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ) ,
        child:ListTile(
          leading: Image.asset(imgUrl),
          trailing: Icon(Icons.arrow_drop_down),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: TextStyle(fontSize: 18.5,
                      color: Colors.black,
                      fontFamily: "Helvetica")),
//              Text(description,
//                  style: TextStyle(
//                    //color: Color(0xFFfeb0ba),
//                      fontSize: 16.0,
//                      fontFamily: "RalewayItalic")),
             // Text("Refills Left: "+refills,style: TextStyle(color: Colors.teal),),
              //Text(getApplienOnString(1)+lastApplied),
            ],

          ),
//            children: <Widget>[
//            //_getStepProgress(),
//              Container(
//                padding: EdgeInsets.fromLTRB(70.0,0.0, 0.0, 2.0),
//                child: Text(description,
//                    style: TextStyle(
//                         color: Color(0xFF003300),
//                        fontSize: 16.0,
//                        fontFamily: "RalewayItalic")),
//              ),


        //  ],
        )
    );





    return Container(
        child: new SizedBox(
          child: exp,

        )
    );
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

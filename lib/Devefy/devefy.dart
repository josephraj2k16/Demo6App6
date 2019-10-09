import 'package:flutter/material.dart';
import 'ProductCard.dart';
import 'CustomIcon.dart';

//void main() => runApp(MaterialApp(
//      home: MyApp(),
//      debugShowCheckedModeBanner: false,
//    ));

class devefy extends StatefulWidget {
  @override
  _devefy1 createState() => new _devefy1();
}

class _devefy1 extends State<devefy> {
  int _currentIndex = 0;

  List<Widget> bottomNavIconList = [
    Image.asset(
      "assets/store.png",
      width: 35.0,
      height: 35.0,
    ),
    Icon(
      CustomIcons.search,
      size: 32.0,
    ),
    Icon(
      CustomIcons.favorite,
      size: 32.0,
    ),
    Icon(CustomIcons.cart, size: 32.0),
    Image.asset("assets/profile.png", width: 35.0, height: 35.0)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Prescriptions")),
     backgroundColor: Colors.white,//Color(0xFFddffcc),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
          child: new Column(
            children: <Widget>[
//              Align(
//                alignment: Alignment.center,
//                child: Padding(
//                  padding: EdgeInsets.only(top: 30.0, bottom: 25.0),
////                  child:
////                    Text("Your Prescriptions"),
//                      //Image.asset("assets/logo.png", width: 62.0, height: 43.0),
//                ),
//              ),
              ProductCard(0xFFccff66, "assets/tab3.jpg",
                  "Mupirocin Ointment", "Use this medication only on skin.Apply three times a day,You may cover the treated area with bandage", "3",
                    "8:38AM"),
              SizedBox(
                height: 30.0,
              ),
              ProductCard(0xFFccff66, "assets/tab2.jpg",
                  "Paracetamol 500 mg", "Take this tablet by mouth after food", "2","10:14AM"),
              SizedBox(
                height: 30.0,
              ),
              ProductCard(0xFFccff66, "assets/tab1.jpg",
                  "Ascorbic Acid 500 mg", "Take this tablet by mouth after food", "1","12:05PM"),
              SizedBox(
                height: 30.0,
              ),
              ProductCard(0xFFccff66, "assets/tab1.jpg",
                  "Enalapril 500 mg", "Take this tablet by mouth after food", "4","3:05PM"),
              SizedBox(
                height: 30.0,
              ),
              ProductCard(0xFFccff66, "assets/tab1.jpg",
                  "Ascorbic Acid 500 mg", "Take this tablet by mouth after food", "1","12:05PM"),
              SizedBox(
                height: 30.0,
              ),
              ProductCard(0xFFccff66, "assets/tab1.jpg",
                  "Ascorbic Acid 500 mg", "Take this tablet by mouth after food", "1","12:05PM"),

            ],
          ),
        ),
      ),
//      bottomNavigationBar: Container(
//        height: 70.0,
//        decoration: BoxDecoration(color: Colors.white, boxShadow: [
//          BoxShadow(
//              color: Colors.black12.withOpacity(0.065),
//              offset: Offset(0.0, -3.0),
//              blurRadius: 10.0)
//        ]),
//        child: Row(
//          children: bottomNavIconList.map((item) {
//            var index = bottomNavIconList.indexOf(item);
//            return Expanded(
//              child: GestureDetector(
//                onTap: () {
//                  setState(() {
//                    _currentIndex = index;
//                  });
//                },
//                child: bottomNavItem(item, index == _currentIndex),
//              ),
//            );
//          }).toList(),
//        ),
//      ),
    );
  }
}

bottomNavItem(Widget item, bool isSelected) => Container(
      decoration: BoxDecoration(
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.02),
                      offset: Offset(0.0, 5.0),
                      blurRadius: 10.0)
                ]
              : []),
      child: item,
    );

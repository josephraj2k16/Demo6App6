import 'package:flutter/material.dart';
import 'package:MediAssist/stepindicator.dart';


class Criterias extends StatefulWidget {
  CriteriaState createState() => new CriteriaState();
}

class NewItem {
  bool isExpanded;
  final Image image;
  final String header;
  final Widget body;
  final Icon iconpic;

  NewItem(this.isExpanded, this.image,this.header, this.body, this.iconpic);
}

double discretevalue = 2.0;
double hospitaldiscretevalue = 25.0;

class CriteriaState extends State<Criterias> {

  final _stepsText = ["About you", "Some more..", "Your credit card details"];

  final _stepCircleRadius = 20.0;

  final title="";

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






  List<NewItem> items = <NewItem>[
    new NewItem(
        false,
        Image.asset("assets/backimage.jpg"),
        'Medicine 1',
        new Padding(
            padding: new EdgeInsets.all(20.0),
            child: new Row(
                children: <Widget>[
                  Text("Apply gently"),
                  new Icon(Icons.access_alarm,size:20.0,color: Colors.black),
                ])
        ),

        new Icon(Icons.add_location, size: 32.0, color: Colors.black),
    ),//give all your items here
  ];

  ListView List_Criteria;
  Widget build(BuildContext context) {
    List_Criteria = new ListView(
      children: [
        new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: items.map((NewItem item) {
              return new ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return new ListTile(
                      leading: item.image,
                      title: new Text(
                        item.header,
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ));
                },
                isExpanded: item.isExpanded,
                body: item.body,
              );
            }).toList(),
          ),
        )
      ],
    );

    Scaffold scaffold = new Scaffold(
      appBar: new AppBar(
        title: new Text("Criteria Selection"),
      ),
      body: List_Criteria,
      persistentFooterButtons: <Widget>[
        new ButtonBar(children: <Widget>[
          new FlatButton(
            color: Colors.blue,
            onPressed: null,
            child: new Text(
              'Apply',
              textAlign: TextAlign.left,
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ])
      ],
    );
    return scaffold;
  }
}
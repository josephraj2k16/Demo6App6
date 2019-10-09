import 'package:MediAssist/charts_dotted.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


class DottedSample extends StatefulWidget {
  @override
  _DottedSampleState createState() => _DottedSampleState();
}

class _DottedSampleState extends State<DottedSample> {
  List<charts.Series<Sample,int>>  _seriesData;
  _generateData(){
    var sampleData= [
        new Sample(8,1,8),
        new Sample(4,2,8),
        new Sample(8,3,8)
        ];

    _seriesData.add(
        charts.Series(
          data: sampleData,
          domainFn: (Sample s,_)=>s.xaxis,
          measureFn: (Sample s,_)=>s.yaxis,
          radiusPxFn: (Sample s,_)=>s.rad,

        ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData=List<charts.Series<Sample,int>>();
    _generateData();

  }

  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: new AppBar(title: new Text("Chart Single Day")),
      body: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(children: <Widget>[
            new SizedBox(height: 200.0, child: charts.ScatterPlotChart(
              _seriesData,
              animate: true,
              animationDuration: Duration(seconds: 2),
            )),//new SimpleScatterPlotChart.withSampleData()
          ])),
//      floatingActionButton: new FloatingActionButton(
//          child: new Icon(Icons.refresh), onPressed: _handleButtonPress),
    );
  }
}
class Sample{
  int yaxis;
  int xaxis;
  int rad;
    Sample(this.yaxis,this.xaxis,this.rad);

}
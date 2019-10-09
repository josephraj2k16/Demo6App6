import 'package:MediAssist/Firebase/cal.dart';

import 'package:MediAssist/Routes.dart';
import 'package:MediAssist/chart_sample.dart';
import 'package:MediAssist/charts_dotted.dart';
import 'package:MediAssist/charts_sample.dart';
import 'package:flutter/material.dart';

import 'Firebase/calendarex.dart';
void main() {
  new Routes();
}

//void main() => runApp(MaterialApp(
//    home:DottedSample(),
//    debugShowCheckedModeBanner: false,
//));



/*

void main() => runApp(MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("Line chart"),
        ),
        body: new Container(
          child: new GalleryScaffold(
            listTileIcon: new Icon(Icons.show_chart),
            title: 'Time Series Chart',
            subtitle: 'Simple single time series chart',
            childBuilder: () => new SimpleTimeSeriesChart.withSampleData(),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    ));

typedef Widget GalleryWidgetBuilder();

/// Helper to build gallery.
class GalleryScaffold extends StatefulWidget {
  /// The widget used for leading in a [ListTile].
  final Widget listTileIcon;
  final String title;
  final String subtitle;
  final GalleryWidgetBuilder childBuilder;

  GalleryScaffold(
      {this.listTileIcon, this.title, this.subtitle, this.childBuilder});

  /// Gets the gallery
  Widget buildGalleryListTile(BuildContext context) => new ListTile(
      leading: listTileIcon,
      title: new Text(title),
      subtitle: new Text(subtitle),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (_) => this));
      });

  @override
  _GalleryScaffoldState createState() => new _GalleryScaffoldState();
}

class _GalleryScaffoldState extends State<GalleryScaffold> {
  void _handleButtonPress() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //appBar: new AppBar(title: new Text(widget.title)),
      body: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(children: <Widget>[
            new SizedBox(height: 200.0, child: widget.childBuilder()),
          ])),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.refresh), onPressed: _handleButtonPress),
    );
  }
}
*/





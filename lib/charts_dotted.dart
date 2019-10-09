import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleScatterPlotChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleScatterPlotChart(this.seriesList, {this.animate});

  /// Creates a [ScatterPlotChart] with sample data and no transition.
  factory SimpleScatterPlotChart.withSampleData() {
    return new SimpleScatterPlotChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.ScatterPlotChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 8.0, 8.0),
      new LinearSales(0, 10.0, 8.0),
      new LinearSales(2, 6.0, 8.0),
      new LinearSales(6, 3.0, 8.0),
      new LinearSales(9, 6.0, 8.0),
//      new LinearSales(24, 3.0, 8.0),
//      new LinearSales(25, 12.0, 8.0),
//      new LinearSales(34, 3.0, 8.0),
//      new LinearSales(37, 10.0, 8.0),
//      new LinearSales(45, 10.0, 8.0),
//      new LinearSales(52, 10.0, 8.0),
//      new LinearSales(56, 10.0, 8.0),
    ];

    final maxMeasure = 12.0;

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        // Providing a color function is optional.
        colorFn: (LinearSales sales, _) {
          // Bucket the measure column value into 3 distinct colors.
          final bucket = sales.sales ;//   / maxMeasure

          if (bucket==6.0 ) {//< 1 / 3
            return charts.MaterialPalette.green.shadeDefault;
          } else if (bucket == 3.0) {//< 2 / 3
            return charts.MaterialPalette.red.shadeDefault;
          } else  {
            return charts.MaterialPalette.green.shadeDefault;
          }
        },
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        // Providing a radius function is optional.
        radiusPxFn: (LinearSales sales, _) => sales.radius,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
   final double sales;
  final double radius;

  LinearSales(this.year, this.sales, this.radius);
}


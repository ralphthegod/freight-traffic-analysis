import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartSample2 extends ConsumerStatefulWidget {

  final List<ChartData> chartData;


  BarChartSample2(this.chartData, {super.key});

  final Color leftBarColor = Colors.greenAccent;
  final Color rightBarColor = Colors.redAccent;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends ConsumerState<BarChartSample2> {
  @override
    Widget build(BuildContext context) {
      final _selectionBehavior = SelectionBehavior(enable: true);
      return Scaffold(
          body: Center(
              child: Container(
                  child: SfCartesianChart(
                    // Mode of selection
                    selectionType: SelectionType.cluster,
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries<ChartData, String>>[
                        ColumnSeries<ChartData, String>(
                            dataSource: widget.chartData,
                            color: widget.leftBarColor,
                            selectionBehavior: _selectionBehavior,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y),
                        ColumnSeries<ChartData, String>(
                            dataSource: widget.chartData,
                            color: widget.rightBarColor,
                            selectionBehavior: _selectionBehavior,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y1)],
                )
            )
          )
      );
    }

}

class ChartData {
      ChartData(this.x, this.y, this.y1);
      final String x;
      final double y;
      final double y1;
  }
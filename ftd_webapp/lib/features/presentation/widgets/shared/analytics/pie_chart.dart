import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends ConsumerStatefulWidget {

  final List<PieChartData> chartData;

  PieChart(this.chartData, {super.key});

  final Color leftBarColor = Colors.greenAccent;
  final Color rightBarColor = Colors.redAccent;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PieChartState();
}

class _PieChartState extends ConsumerState<PieChart> {
  @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: Container(
                    child: SfCircularChart(
                        series: <CircularSeries>[
                            PieSeries<PieChartData, double>(
                                dataSource: widget.chartData,
                                xValueMapper: (PieChartData data, _) => data.x,
                                yValueMapper: (PieChartData data, _) => data.y,
                                dataLabelMapper: (PieChartData data, _) => data.text,
                                pointColorMapper: (PieChartData data, _) => data.color,
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true
                                )
                            )
                        ]
                    )
                )
            )
        );
    }

}

class PieChartData {
      PieChartData(this.x, this.y, this.text, this.color);
      final String text;
      final double x;
      final double y;
      final MaterialColor color;
}
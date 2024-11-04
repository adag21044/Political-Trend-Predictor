import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrendChart extends StatelessWidget {
  final double democratCount;
  final double republicanCount;

  const TrendChart({required this.democratCount, required this.republicanCount});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: 'Political Trends'),
      legend: Legend(isVisible: true),
      series: <CircularSeries>[
        PieSeries<_ChartData, String>(
          dataSource: [
            _ChartData('Democrat', democratCount, Colors.blue),
            _ChartData('Republican', republicanCount, Colors.red),
          ],
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          pointColorMapper: (_ChartData data, _) => data.color,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class _ChartData {
  final String x;
  final double y;
  final Color color;

  _ChartData(this.x, this.y, this.color);
}

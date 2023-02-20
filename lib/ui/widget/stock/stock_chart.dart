import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../theme/app_color.dart';

class LineChartSample2 extends StatefulWidget {
  final double height;

  const LineChartSample2({super.key, this.height = 90});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  var list = [
    27.3,
    27.35,
    27.3,
    27.3,
    27.3,
    27.3,
    27.45,
    27.4,
    27.5,
    27.45,
    27.35,
    27.4,
    27.35,
    27.3,
    27.3
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          LineChart(mainData),
        ],
      ),
    );
  }

  LineChartData get mainData {
    return LineChartData(
      gridData: FlGridData(
          drawVerticalLine: false,
          drawHorizontalLine: true,
          checkToShowHorizontalLine: (double value) {
            if (value == 0) return true;
            return true;
          }),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(),
          leftTitles: AxisTitles(),
          rightTitles: AxisTitles(sideTitles: SideTitles()),
          bottomTitles: AxisTitles()),
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
              list.length, (index) => FlSpot(index.toDouble(), list[index])),
          isCurved: true,
          barWidth: 1,
          dotData: FlDotData(show: false),
          color: AppColors.semantic_03,
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }
}

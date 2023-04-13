// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SparklineWidget extends StatefulWidget {
  final List<double>? sparkline;
  final List<FlSpot>? flSpotList;
  final bool showBarArea;
  final num pricePercentage;

  const SparklineWidget({
    required this.sparkline,
    required this.flSpotList,
    required this.showBarArea,
    required this.pricePercentage,
    Key? key,
  }) : super(key: key);

  @override
  _SparklineWidgetState createState() => _SparklineWidgetState();
}

class _SparklineWidgetState extends State<SparklineWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: LineChart(
            mainData(),
            swapAnimationCurve: Curves.linear,
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (double value) {
          return FlLine(
            color: widget.pricePercentage >= 0 ? Colors.green : Colors.red,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (double value) {
          return FlLine(
            color: widget.pricePercentage >= 0 ? Colors.green : Colors.red,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(
              color: widget.pricePercentage >= 0 ? Colors.green : Colors.red,
              width: 1)),
      minX: 0,
      maxX: widget.sparkline?.length.toDouble(),
      minY: widget.sparkline?.reduce(min),
      maxY: widget.sparkline?.reduce(max),
      lineBarsData: <LineChartBarData>[
        LineChartBarData(
          spots: widget.flSpotList,
          isCurved: true,
          color: widget.pricePercentage >= 0 ? Colors.green : Colors.red,
          barWidth: 1,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: widget.showBarArea,
            color: widget.pricePercentage >= 0 ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}

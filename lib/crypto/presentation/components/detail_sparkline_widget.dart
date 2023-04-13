// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailSparklineWidget extends StatefulWidget {
  final List<double>? sparkline;
  final List<FlSpot>? flSpotList;
  final bool showBarArea;
  final num pricePercentage;

  const DetailSparklineWidget({
    required this.sparkline,
    required this.flSpotList,
    required this.showBarArea,
    required this.pricePercentage,
    Key? key,
  }) : super(key: key);

  @override
  _SparklineWidgetState createState() => _SparklineWidgetState();
}

class _SparklineWidgetState extends State<DetailSparklineWidget> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      mainData(),
      swapAnimationCurve: Curves.linear,
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
          tooltipBorder: BorderSide(
            color: widget.pricePercentage >= 0 ? Colors.green : Colors.red,
            width: 2,
          ),
        ),
      ),
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (double value) {
          return FlLine(
            color: const Color(0xff212121),
            strokeWidth: 1,
          );
        },
        verticalInterval: 24,
        getDrawingVerticalLine: (double value) {
          return FlLine(
            color: const Color(0xff212121),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              const style = TextStyle(
                color: Colors.black,
                fontSize: 10,
              );
              Widget text;
              switch (value.toInt()) {
                case 0:
                  text = Text(
                      DateFormat('d/M')
                          .format(
                              DateTime.now().subtract(const Duration(days: 7)))
                          .toString(),
                      style: style);
                  break;
                case 24:
                  text = Text(
                      DateFormat('d/M')
                          .format(
                              DateTime.now().subtract(const Duration(days: 6)))
                          .toString(),
                      style: style);
                  break;
                case 48:
                  text = Text(
                      DateFormat('d/M')
                          .format(
                              DateTime.now().subtract(const Duration(days: 5)))
                          .toString(),
                      style: style);
                  break;
                case 72:
                  text = Text(
                      DateFormat('d/M')
                          .format(
                              DateTime.now().subtract(const Duration(days: 4)))
                          .toString(),
                      style: style);
                  break;
                case 96:
                  text = Text(
                      DateFormat('d/M')
                          .format(
                              DateTime.now().subtract(const Duration(days: 3)))
                          .toString(),
                      style: style);
                  break;
                case 120:
                  text = Text(
                      DateFormat('d/M')
                          .format(
                              DateTime.now().subtract(const Duration(days: 2)))
                          .toString(),
                      style: style);
                  break;
                case 144:
                  text = Text(
                      DateFormat('d/M')
                          .format(
                              DateTime.now().subtract(const Duration(days: 1)))
                          .toString(),
                      style: style);
                  break;
                case 168:
                  text = Text(
                      DateFormat('d/M').format(DateTime.now()).toString(),
                      style: style);
                  break;
                default:
                  text = const Text('', style: style);
                  break;
              }
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: text,
              );
            },
            interval: 1,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: widget.pricePercentage >= 0 ? Colors.green : Colors.red,
              width: 2),
          left: BorderSide(
              color: widget.pricePercentage >= 0 ? Colors.green : Colors.red,
              width: 2),
        ),
      ),
      minX: 0,
      maxX: widget.sparkline?.length.toDouble(),
      minY: widget.sparkline?.reduce(min),
      maxY: widget.sparkline?.reduce(max),
      lineBarsData: <LineChartBarData>[
        LineChartBarData(
          spots: widget.flSpotList,
          isCurved: false,
          color: widget.pricePercentage >= 0 ? Colors.green : Colors.red,
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: widget.showBarArea,
            color: widget.pricePercentage >= 0
                ? Colors.green.withOpacity(0.5)
                : Colors.red.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

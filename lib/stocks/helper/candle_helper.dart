import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../api/api.dart';
import '../helper/helper.dart';
import '../models/models.dart';

extension CandleHelper on List<Candle> {
  static const padding = 0.015;

  double get max => fold(-double.infinity, (a, b) => a > b.high ? a : b.high);

  double get min => fold(double.infinity, (a, b) => a < b.low ? a : b.low);

  double get minimumPlotValue => (min * (1 - padding)).roundToDouble();

  double get maximumPlotValue => (max * (1 + padding)).roundToDouble();

  CandleSeries<Candle, String> candleSeries(Resolution resolution) {
    return CandleSeries<Candle, String>(
      xValueMapper: (c, _) => c.timestamp.formatFromResolution(resolution),
      dataSource: this,
      openValueMapper: (c, _) => c.open,
      highValueMapper: (c, _) => c.high,
      closeValueMapper: (c, _) => c.close,
      lowValueMapper: (c, _) => c.low,
      bearColor: Colors.red,
      bullColor: Colors.green,
    );
  }

  double interval(
    bool isPortrait, {
    int desiredPortraitInterval = 16,
  }) {
    final desiredLines =
        isPortrait ? desiredPortraitInterval : desiredPortraitInterval / 2;
    final plotHeight = max - min;
    final interval = (plotHeight / desiredLines).roundToDouble();
    return interval > 0 ? interval : 0.1; // Check for positive interval
  }
}

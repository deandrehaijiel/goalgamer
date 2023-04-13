// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../api/api.dart';
import '../helper/helper.dart';
import '../models/models.dart';
import '../state/state.dart';

class StockChartWidget extends StatefulWidget {
  final Function toggleSearchWidget;

  const StockChartWidget({
    Key? key,
    required this.toggleSearchWidget,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => StockChartWidgetState();
}

class StockChartWidgetState extends State<StockChartWidget> {
  String appBarTitle(GetCandlesRequest recentQuery) =>
      "${recentQuery.symbol.toUpperCase()} ${recentQuery.resolution.label} Chart";

  DateTime now = DateTime.now().toUtc().subtract(const Duration(hours: 4));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StocksAppStateCubit, AppState>(
        builder: (context, state) {
      final recentQuery = state.recentQuery;
      if (recentQuery == null) {
        // handle null case here
        return Container();
      }
      if (state.isLoading) {
        const color = Colors.white;
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width / 4.2,
          child: const Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: LoadingIndicator(
                indicatorType: Indicator.audioEqualizer,
                backgroundColor: color,
                pathBackgroundColor: color,
                colors: [
                  Colors.red,
                  Colors.green,
                ],
              ),
            ),
          ),
        );
      }
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 4.2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
              ),
              child: Row(
                children: [
                  IconButton(
                    splashRadius: 0.1,
                    onPressed: () => setState(() {
                      widget.toggleSearchWidget();
                    }),
                    icon: const Icon(Icons.arrow_back_ios_rounded,
                        color: Colors.black),
                  ),
                  Text(
                    appBarTitle(recentQuery),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Builder(builder: (context) {
                if (state.hasError) {
                  return Center(
                    child: Text(
                      "Your search failed with the following message:"
                      "\n${state.errorMessage}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                  );
                }
                final candles = state.candles;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      labelStyle: const TextStyle(
                        color: Colors.black, // set the color here
                      ),
                      interactiveTooltip: const InteractiveTooltip(
                        color: Colors.black,
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    primaryYAxis: NumericAxis(
                      minimum: candles.minimumPlotValue,
                      maximum: candles.maximumPlotValue,
                      interval: candles.interval(true),
                      labelStyle: const TextStyle(
                        color: Colors.black, // set the color here
                      ),
                      interactiveTooltip: const InteractiveTooltip(
                        color: Colors.black,
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    series: <ChartSeries<Candle, String>>[
                      candles.candleSeries(recentQuery.resolution),
                    ],
                    // Define the crosshair behavior
                    crosshairBehavior: CrosshairBehavior(
                      enable: true,
                      lineType: CrosshairLineType.both,
                      activationMode: ActivationMode.longPress,
                      shouldAlwaysShow: true,
                      lineColor: Colors.black,
                    ),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Visibility(
                visible: now.weekday == DateTime.saturday ||
                        now.weekday == DateTime.sunday ||
                        now.weekday == DateTime.monday
                    ? false
                    : true,
                child: Row(
                  children: [
                    Flexible(
                      child: MaterialButton(
                        onPressed: () {
                          final newQuery = state.recentQuery!.copyWith(
                            resolution: Resolution.oneMinute,
                            from: DateTime.now()
                                .subtract(const Duration(days: 1)),
                          );
                          context
                              .read<StocksAppStateCubit>()
                              .fetchCandles(newQuery);
                        },
                        child: const Text(
                          '1m',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: MaterialButton(
                        onPressed: () {
                          final newQuery = state.recentQuery!.copyWith(
                            resolution: Resolution.fiveMinutes,
                            from: DateTime.now()
                                .subtract(const Duration(days: 1)),
                          );
                          context
                              .read<StocksAppStateCubit>()
                              .fetchCandles(newQuery);
                        },
                        child: const Text(
                          '5m',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: MaterialButton(
                        onPressed: () {
                          final newQuery = state.recentQuery!.copyWith(
                            resolution: Resolution.fifteenMinutes,
                            from: DateTime.now()
                                .subtract(const Duration(days: 1)),
                          );
                          context
                              .read<StocksAppStateCubit>()
                              .fetchCandles(newQuery);
                        },
                        child: const Text(
                          '15m',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: MaterialButton(
                        onPressed: () {
                          final newQuery = state.recentQuery!.copyWith(
                            resolution: Resolution.thirtyMinutes,
                            from: DateTime.now()
                                .subtract(const Duration(days: 1)),
                          );
                          context
                              .read<StocksAppStateCubit>()
                              .fetchCandles(newQuery);
                        },
                        child: const Text(
                          '30m',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: MaterialButton(
                        onPressed: () {
                          final newQuery = state.recentQuery!.copyWith(
                            resolution: Resolution.hour,
                            from: DateTime.now()
                                .subtract(const Duration(days: 1)),
                          );
                          context
                              .read<StocksAppStateCubit>()
                              .fetchCandles(newQuery);
                        },
                        child: const Text(
                          '1h',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: MaterialButton(
                        onPressed: () {
                          final newQuery = state.recentQuery!.copyWith(
                            resolution: Resolution.day,
                            from: DateTime.now()
                                .subtract(const Duration(days: 10)),
                          );
                          context
                              .read<StocksAppStateCubit>()
                              .fetchCandles(newQuery);
                        },
                        child: const Text(
                          '1d',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: MaterialButton(
                        onPressed: () {
                          final newQuery = state.recentQuery!.copyWith(
                            resolution: Resolution.month,
                            from: DateTime.now()
                                .subtract(const Duration(days: 300)),
                          );
                          context
                              .read<StocksAppStateCubit>()
                              .fetchCandles(newQuery);
                        },
                        child: const Text(
                          '1M',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

// ignore_for_file: unused_field, deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/data.dart';
import '../components/components.dart';
import 'widgets.dart';

class AnalyticsWidget extends StatefulWidget {
  const AnalyticsWidget({super.key});

  @override
  State<AnalyticsWidget> createState() => _AnalyticsWidgetState();
}

class _AnalyticsWidgetState extends State<AnalyticsWidget> {
  int touchedIndex = -1;
  double turns = 0.0;

  // reference the hive box
  final _goalsBox = Hive.box('goalsbox');
  GoalsDatabase db = GoalsDatabase();
  final _achievedGoalsBox = Hive.box('achievedgoalsbox');
  AchievedGoalsDatabase dbAchieved = AchievedGoalsDatabase();

  @override
  void initState() {
    super.initState();
    // if this is the 1st time ever opening the app, then create default data
    if (_goalsBox.get("GOALSLIST") == null) {
      _goalsBox.put("GOALSLIST", db.createInitialData());
    } else {
      // there already exists data
      db.loadData();
    }
    // if this is the 1st time ever opening the app, then create default data
    if (_achievedGoalsBox.get("ACHIEVEDGOALSLIST") == null) {
      _achievedGoalsBox.put(
          "ACHIEVEDGOALSLIST", dbAchieved.createInitialData());
    } else {
      // there already exists data
      dbAchieved.loadData();
    }
  }

  double achievedGoalsPercentage() {
    int totalGoals = db.goalsList.length + dbAchieved.achievedGoalsList.length;
    if (totalGoals == 0) {
      return 0;
    }
    double achievedGoalsPercent =
        dbAchieved.achievedGoalsList.length / totalGoals;
    return achievedGoalsPercent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width / 3.99,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ValueListenableBuilder(
                valueListenable: _goalsBox.listenable(),
                builder: (context, box, widget) {
                  db.loadData();
                  return ValueListenableBuilder(
                    valueListenable: _achievedGoalsBox.listenable(),
                    builder: (context, box, widget) {
                      dbAchieved.loadData();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 270,
                            height: 270,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(135),
                            ),
                            child: Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                      pieTouchData: PieTouchData(
                                        touchCallback: (FlTouchEvent event,
                                            pieTouchResponse) {
                                          setState(() {
                                            if (!event
                                                    .isInterestedForInteractions ||
                                                pieTouchResponse == null ||
                                                pieTouchResponse
                                                        .touchedSection ==
                                                    null) {
                                              touchedIndex = -1;
                                              return;
                                            }
                                            touchedIndex = pieTouchResponse
                                                .touchedSection!
                                                .touchedSectionIndex;
                                          });
                                        },
                                      ),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 80,
                                      sections: showingGoals(),
                                      startDegreeOffset: -180,
                                    ),
                                  ),
                                ),
                                const Center(
                                  child: BlurWidget(),
                                ),
                                Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'DONE',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      '${dbAchieved.achievedGoalsList.length}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: Colors.black),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 19),
            const QuoteWidget(),
            const LottieWidget(),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingGoals() {
    return List.generate(
      2,
      (i) {
        final isTouched = i == touchedIndex;
        final radius = isTouched ? 74.0 : 64.0;
        switch (i) {
          case 0:
            return PieChartSectionData(
              color: Colors.green,
              value: achievedGoalsPercentage(),
              radius: radius,
              showTitle: false,
            );
          case 1:
            return PieChartSectionData(
              color: Colors.transparent,
              value: (1 - achievedGoalsPercentage()),
              radius: radius,
              showTitle: false,
            );

          default:
            throw Error();
        }
      },
    );
  }
}

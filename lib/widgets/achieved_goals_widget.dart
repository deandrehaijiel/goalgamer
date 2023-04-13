// ignore_for_file: unused_field

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../data/data.dart';
import '../components/components.dart';

class AchievedGoalsWidget extends StatefulWidget {
  const AchievedGoalsWidget({super.key});

  @override
  State<AchievedGoalsWidget> createState() => _AchievedGoalsWidgetState();
}

class _AchievedGoalsWidgetState extends State<AchievedGoalsWidget> {
  // reference the hive box
  final _achievedGoalsBox = Hive.box('achievedgoalsbox');
  AchievedGoalsDatabase dbAchieved = AchievedGoalsDatabase();

  final GlobalKey<AnimatedListState> _dailyAchievedkey = GlobalKey();
  final _scrollAchievedGoalController = ScrollController();

  @override
  void initState() {
    super.initState();
    // if this is the 1st time ever opening the app, then create default data
    if (_achievedGoalsBox.get("ACHIEVEDGOALSLIST") == null) {
      dbAchieved.createInitialData();
    } else {
      // there already exists data
      dbAchieved.loadData();
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  // delete achieved goal
  void deleteAchievedGoal(int index) async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    setState(
      () {
        dbAchieved.achievedGoalsList.removeAt(index);
      },
    );
    dbAchieved.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 3),
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: _achievedGoalsBox.listenable(),
        builder: (context, box, widget) {
          // Rebuild the achieved goals list when the box is updated
          dbAchieved.loadData();
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3.051,
            width: MediaQuery.of(context).size.width / 4.1,
            child: AnimationLimiter(
              child: FadingEdgeScrollView.fromScrollView(
                child: ListView.builder(
                  controller: _scrollAchievedGoalController,
                  key: _dailyAchievedkey,
                  itemCount: dbAchieved.achievedGoalsList.length,
                  itemBuilder: (context, index) {
                    final entry = dbAchieved.achievedGoalsList[index];
                    final date = entry[2] as DateTime;
                    final prevEntry = index > 0
                        ? dbAchieved.achievedGoalsList[index - 1]
                        : null;
                    final prevDate =
                        prevEntry != null ? prevEntry[2] as DateTime : null;
                    if (prevDate == null || !isSameDay(date, prevDate)) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      DateFormat('EEEE, d MMMM y').format(date),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                AchievedTile(
                                  title: entry[0] as String,
                                  deleteFunction: (context) =>
                                      deleteAchievedGoal(index),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: AchievedTile(
                              title: entry[0] as String,
                              deleteFunction: (context) =>
                                  deleteAchievedGoal(index),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

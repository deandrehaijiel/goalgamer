// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/data.dart';
import '../components/components.dart';
import 'widgets.dart';

class GoalsWidget extends StatefulWidget {
  const GoalsWidget({super.key});

  @override
  State<GoalsWidget> createState() => _GoalsWidgetState();
}

class _GoalsWidgetState extends State<GoalsWidget> {
  // reference the hive box
  final _goalsBox = Hive.box('goalsbox');
  GoalsDatabase db = GoalsDatabase();
  final _achievedGoalsBox = Hive.box('achievedgoalsbox');
  AchievedGoalsDatabase dbAchieved = AchievedGoalsDatabase();

  final GlobalKey<AnimatedListState> _goalsKey = GlobalKey();
  final _scrollGoalController = ScrollController();

  bool _isPositionedVisible = true;

  // text controller
  final _controller = TextEditingController();

  void _handleGoalScroll() {
    if (_scrollGoalController.offset > 0 &&
        _scrollGoalController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      // scroll is going down, hide the Positioned element
      setState(
        () {
          _isPositionedVisible = false;
        },
      );
    } else if (_scrollGoalController.offset <= 0 ||
        _scrollGoalController.position.userScrollDirection ==
            ScrollDirection.forward) {
      // scroll is going up or at the top, show the Positioned element
      setState(
        () {
          _isPositionedVisible = true;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // if this is the 1st time ever opening the app, then create default data
    if (_goalsBox.get("GOALSLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    // if this is the 1st time ever opening the app, then create default data
    if (_achievedGoalsBox.get("ACHIEVEDGOALSLIST") == null) {
      dbAchieved.createInitialData();
    } else {
      // there already exists data
      dbAchieved.loadData();
    }
    _scrollGoalController.addListener(_handleGoalScroll);
  }

  // checkbox was tapped, goal achieved
  void checkBoxChanged(bool? value, int index) async {
    setState(() {
      db.goalsList[index][1] = !db.goalsList[index][1];
    });
    await Future.delayed(const Duration(milliseconds: 500), () {});
    setState(
      () {
        _goalsKey.currentState!.removeItem(index, (context, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: Container(),
          );
        }, duration: const Duration(milliseconds: 375));
      },
    );
    dbAchieved.achievedGoalsList
        .add([db.goalsList[index][0], true, DateTime.now()]);
    db.goalsList.removeAt(index);
    dbAchieved.updateDatabase();
    db.updateDatabase();
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: 18),
                child: Text(
                  'To add new goals, please make sure you have marked all the introduction goals as achieved first.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Icon(Icons.warning_rounded, color: Colors.white)
          ],
        ),
      ),
    );
  }

  // add a new goal
  void addNewGoal() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ModalBottomSheet(
              controller: _controller,
              onSave: saveNewGoal,
            ),
          ),
        );
      },
    );
  }

  // save new goal
  void saveNewGoal() async {
    final int index = db.goalsList.length;
    setState(
      () {
        db.goalsList.add([_controller.text, false]);
        _controller.clear();
      },
    );
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {},
    );
    setState(() {
      _goalsKey.currentState!
          .insertItem(index, duration: const Duration(milliseconds: 375));
    });
    db.updateDatabase();
    Navigator.of(context).pop();
  }

  // delete goal
  void deleteGoal(int index) async {
    await Future.delayed(const Duration(milliseconds: 500), () {});
    setState(
      () {
        _goalsKey.currentState!.removeItem(index, (context, animation) {
          return SizeTransition(
            sizeFactor: animation,
            child: Container(),
          );
        }, duration: const Duration(milliseconds: 375));
        db.goalsList.removeAt(index);
      },
    );
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width / 4.1,
      child: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _achievedGoalsBox.listenable(),
            builder: (context, box, widget) {
              db.loadData();
              return Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3.051,
                    width: MediaQuery.of(context).size.width / 4.1,
                    child: AnimationLimiter(
                      child: FadingEdgeScrollView.fromAnimatedList(
                        child: AnimatedList(
                          controller: _scrollGoalController,
                          key: _goalsKey,
                          initialItemCount: db.goalsList.length,
                          itemBuilder: (context, index, animation) {
                            bool isLastTile = index == db.goalsList.length - 1;
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 750),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: isLastTile ? 24 : 0.0,
                                    ),
                                    child: Tile(
                                      title: db.goalsList[index][0],
                                      goalAchieved: db.goalsList[index][1],
                                      onChanged: (value) =>
                                          {checkBoxChanged(value, index)},
                                      deleteFunction: (context) =>
                                          deleteGoal(index),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 375),
                    bottom: _isPositionedVisible ? 10 : -100,
                    right: 10,
                    child: FloatingActionButton(
                      onPressed: () => addNewGoal(),
                      backgroundColor: Colors.black,
                      child: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const AchievedGoalsWidget()
        ],
      ),
    );
  }
}

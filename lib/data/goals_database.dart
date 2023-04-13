import 'package:hive_flutter/hive_flutter.dart';

class GoalsDatabase {
  List goalsList = [];

  // reference our box
  final _goalsBox = Hive.box('goalsbox');

  // run this method if this is the 1st time ever opening this app
  List createInitialData() {
    goalsList = [
      ["Take the first step towards achieving your goals today. ", false],
      [
        "To mark a goal as achieved, simply tap on the circle located on the left side of the goal tile. ",
        false
      ],
      [
        "To start adding new goals, it is necessary to mark all the introduction goals as achieved first. Only then will you be able to move forward and set new goals. ",
        false
      ]
    ];
    // return the updated goalsList
    return goalsList;
  }

  // load the data from database
  void loadData() {
    goalsList = _goalsBox.get("GOALSLIST");
  }

  // update the database
  void updateDatabase() {
    _goalsBox.put("GOALSLIST", goalsList);
  }
}

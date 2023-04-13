import 'package:hive_flutter/hive_flutter.dart';

class AchievedGoalsDatabase {
  List achievedGoalsList = [];

  // reference our box
  final _achievedGoalsBox = Hive.box('achievedgoalsbox');

  // run this method if this is the 1st time ever opening this app
  List createInitialData() {
    achievedGoalsList = [
      [
        "To delete a goal, swipe left on the goal tile and tap on the delete icon that appears on the right side of the tile.",
        true,
        DateTime.now(),
      ]
    ];
    // return the updated goalsList
    return achievedGoalsList;
  }

  // load the data from database
  void loadData() {
    achievedGoalsList = _achievedGoalsBox.get("ACHIEVEDGOALSLIST");
  }

  // update the database
  void updateDatabase() {
    _achievedGoalsBox.put("ACHIEVEDGOALSLIST", achievedGoalsList);
  }
}

import 'package:hive_flutter/hive_flutter.dart';

import '../models/models.dart';

class ExpensesDatabase {
  // reference our box
  final _expensesBox = Hive.box('expensesbox');

  // write data
  void saveData(List<ExpenseItem> allExpense) {
    /*

    Hive can only store strings and dateTime, and not custom objects like ExpenseItem.
    So lets convert ExpenseItem objects into types that can be stored in db

    allExpense =

    [

      ExpenseItem ( name / amount / dateTime )
      ..

    ]

    ->

    [

    [ name, amount, dateTime ]
    ..

    ]

    */

    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      // convert each expenseItem into a list of storable type (strings, dateTime)
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    // finally lets store in our database!
    _expensesBox.put("EXPENSESLIST", allExpensesFormatted);
  }

  // read data
  List<ExpenseItem> readData() {
    /*

    Data is stored in Hive as a list of strings + dateTime
    so lets convert our saved data into ExpenseItem objects

    savedData =
    [

    [ name, amount, dateTime ],
    ..

    ]

    ->

    [

    Expense ( name / amount / dateTime ),
    ..

    ]

    */

    List savedExpense = _expensesBox.get("EXPENSESLIST") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpense.length; i++) {
      // collect individual expense data
      String name = savedExpense[i][0];
      String amount = savedExpense[i][1];
      DateTime dateTime = savedExpense[i][2];

      // create expense item
      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      // add expense to overall list of expenses
      allExpenses.add(expense);
    }

    return allExpenses;
  }
}

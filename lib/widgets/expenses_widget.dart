import 'package:animations/animations.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:goalgamer/components/expense_summary.dart';
import 'package:goalgamer/data/data.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../models/models.dart';

class ExpensesWidget extends StatefulWidget {
  const ExpensesWidget({super.key});

  @override
  State<ExpensesWidget> createState() => _ExpensesWidgetState();
}

class _ExpensesWidgetState extends State<ExpensesWidget> {
  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseDollarsController = TextEditingController();
  final newExpenseCentsController = TextEditingController();

  final _scrollController = ScrollController();

  bool validNameEntry = true;
  bool validDollarsEntry = true;
  bool validCentsEntry = true;

  bool _isPositionedVisible = true;

  void _handleGoalScroll() {
    if (_scrollController.offset > 0 &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      // scroll is going down, hide the Positioned element
      setState(
        () {
          _isPositionedVisible = false;
        },
      );
    } else if (_scrollController.offset <= 0 ||
        _scrollController.position.userScrollDirection ==
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

    // prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();

    _scrollController.addListener(_handleGoalScroll);
  }

  // add new expense
  void addNewExpense() {
    showModal(
      configuration: NonDismissibleModalConfiguration(),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add new expense'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            // expense name
            TextField(
              controller: newExpenseNameController,
              onChanged: (value) => setState(() {
                if (newExpenseNameController.text.isNotEmpty) {
                  setState(() {
                    validNameEntry = true;
                  });
                }
              }),
              decoration: InputDecoration(
                hintText: "Expense name",
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: validNameEntry ? Colors.grey : Colors.red,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: validNameEntry ? Colors.grey : Colors.red,
                  ),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: validNameEntry ? Colors.grey : Colors.red,
                  ),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: validNameEntry ? Colors.grey : Colors.red,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: validNameEntry ? Colors.grey : Colors.red,
                  ),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: validNameEntry ? Colors.grey : Colors.red,
                  ),
                ),
              ),
            ),

            Row(
              children: [
                // dollars
                Expanded(
                  child: TextField(
                    controller: newExpenseDollarsController,
                    onChanged: (value) => setState(() {
                      if (newExpenseDollarsController.text.isNotEmpty) {
                        setState(() {
                          validDollarsEntry = true;
                        });
                      }
                    }),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: "Dollars",
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validDollarsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validDollarsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validDollarsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validDollarsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validDollarsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validDollarsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // cents
                Expanded(
                  child: TextField(
                    controller: newExpenseCentsController,
                    onChanged: (value) => setState(() {
                      if (newExpenseCentsController.text.isNotEmpty) {
                        setState(() {
                          validCentsEntry = true;
                        });
                      }
                    }),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: "Cents",
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validCentsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validCentsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validCentsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validCentsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validCentsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: validCentsEntry ? Colors.grey : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ]),
          actions: [
            // cancel button
            MaterialButton(
              onPressed: () {
                {
                  Navigator.of(context).pop();
                  clear();
                  setState(() {
                    validNameEntry = true;
                    validDollarsEntry = true;
                    validCentsEntry = true;
                  });
                }
              },
              child: const Text('Cancel'),
            ),

            // save
            MaterialButton(
              onPressed: () {
                if (newExpenseNameController.text.isEmpty) {
                  setState(() {
                    validNameEntry = false;
                  });
                }

                if (newExpenseDollarsController.text.isEmpty) {
                  setState(() {
                    validDollarsEntry = false;
                  });
                }

                if (newExpenseCentsController.text.isEmpty) {
                  setState(() {
                    validCentsEntry = false;
                  });
                }

                // only save expense if all fields are filled
                if (newExpenseNameController.text.isNotEmpty &&
                    newExpenseDollarsController.text.isNotEmpty &&
                    newExpenseCentsController.text.isNotEmpty) {
                  // Add a zero if the user entered a single digit
                  String cents = newExpenseCentsController.text;
                  if (cents.length == 1) {
                    cents = '${cents}0';
                  }

                  // put dollars and cents together
                  String amount = '${newExpenseDollarsController.text}.$cents';

                  // create expense item
                  ExpenseItem newExpense = ExpenseItem(
                    name: newExpenseNameController.text,
                    amount: amount,
                    dateTime: DateTime.now(),
                  );

                  // add the new expense
                  Provider.of<ExpenseData>(context, listen: false)
                      .addNewExpense(newExpense);

                  Navigator.of(context).pop();
                  clear();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // clear controllers
  void clear() {
    newExpenseNameController.clear();
    newExpenseDollarsController.clear();
    newExpenseCentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 4.1,
        child: Stack(
          children: [
            Column(
              children: [
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),

                const SizedBox(height: 20),

                // expense list
                Expanded(
                  child: AnimationLimiter(
                    child: FadingEdgeScrollView.fromScrollView(
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: value.getAllExpenseList().length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: ExpenseTile(
                                  name: value
                                      .getAllExpenseList()[
                                          (value.getAllExpenseList().length -
                                                  1) -
                                              index]
                                      .name,
                                  amount: value
                                      .getAllExpenseList()[
                                          (value.getAllExpenseList().length -
                                                  1) -
                                              index]
                                      .amount,
                                  dateTime: value
                                      .getAllExpenseList()[
                                          (value.getAllExpenseList().length -
                                                  1) -
                                              index]
                                      .dateTime,
                                  deleteTapped: (p0) => deleteExpense(value
                                          .getAllExpenseList()[
                                      (value.getAllExpenseList().length - 1) -
                                          index]),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 375),
              bottom: _isPositionedVisible ? 10 : -100,
              right: 10,
              child: FloatingActionButton(
                onPressed: addNewExpense,
                backgroundColor: Colors.black,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Slidable(
          endActionPane: ActionPane(
              extentRatio: 0.2,
              motion: const StretchMotion(),
              children: [
                // delete button
                SlidableAction(
                  onPressed: deleteTapped,
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                  padding: const EdgeInsets.all(0),
                ),
              ]),
          child: ListTile(
            title: Text(
              name,
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              '${dateTime.day}/${dateTime.month}/${dateTime.year}',
              style: const TextStyle(color: Colors.black),
            ),
            trailing: Text(
              '\$$amount',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AchievedTile extends StatelessWidget {
  final String title;
  Function(BuildContext)? deleteFunction;

  AchievedTile({Key? key, required this.title, required this.deleteFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 12,
      ),
      child: Row(
        children: [
          // checkbox
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey[400],
                child: const Icon(
                  Icons.done,
                  color: Colors.black,
                )),
          ),
          Expanded(
            child: Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const BehindMotion(),
                children: [
                  SlidableAction(
                    onPressed: deleteFunction,
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                    padding: const EdgeInsets.all(0),
                  )
                ],
              ),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Row(
                      children: [
                        // goal name
                        Flexible(
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                title,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                            isRepeatingAnimation: false,
                            displayFullTextOnTap: true,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

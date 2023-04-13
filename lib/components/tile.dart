// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Tile extends StatelessWidget {
  final String title;
  final bool goalAchieved;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  Tile(
      {Key? key,
      required this.title,
      required this.goalAchieved,
      required this.onChanged,
      required this.deleteFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Row(
        children: [
          // checkbox
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey[400],
              child: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  value: goalAchieved,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                  splashRadius: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  side: const BorderSide(color: Colors.transparent),
                  fillColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  checkColor: Colors.black,
                ),
              ),
            ),
          ),
          if (title !=
                  "Take the first step towards achieving your goals today" &&
              title !=
                  "When you have achieved your goal, tap on the circle on the left side of the goal tile")
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
                                    decoration: TextDecoration.none,
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
            )
          else
            Expanded(
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
                                  decoration: TextDecoration.none,
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
        ],
      ),
    );
  }
}

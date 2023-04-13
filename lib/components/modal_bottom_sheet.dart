// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  final controller;
  VoidCallback onSave;

  ModalBottomSheet({
    Key? key,
    required this.controller,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // title
          const Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'NEW GOAL',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),

          // get user input
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              autofocus: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => onSave(),
              autocorrect: false,
              style: const TextStyle(
                color: Colors.black,
              ),
              controller: controller,
              decoration: InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
                hintText: 'Enter Goal Here',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // save button
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              right: 10,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: onSave,
                child: const Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/components.dart';

class BatteryWidget extends StatefulWidget {
  const BatteryWidget({super.key});

  @override
  _BatteryWidgetState createState() => _BatteryWidgetState();
}

class _BatteryWidgetState extends State<BatteryWidget> {
  double batteryWidth = 150;
  late int durationInput;
  late int durationLeft;
  bool gameStarted = false;
  Timer? _timer;
  final _durationController = TextEditingController();
  bool invalidPlayTime = false;

  @override
  void initState() {
    super.initState();
    loadSavedDurationAndWidth(isRestart: true);
    startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadSavedDurationAndWidth();
  }

  void startTimer() async {
    _timer?.cancel();
    durationInput = int.tryParse(_durationController.text) ?? 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final closingTime =
        prefs.getInt('closingTime') ?? DateTime.now().millisecondsSinceEpoch;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final timeDifference = (currentTime - closingTime) ~/ 1000;
    durationLeft = (durationInput * 3600) - timeDifference;
    if (durationLeft < 0) {
      durationLeft = 0;
    }
    batteryWidth = 150 * (durationLeft / (durationInput * 3600));
    saveDurationAndWidth();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (durationLeft > 0) {
          durationLeft--;
          batteryWidth -= 150 / (durationInput * 3600);
          saveDurationAndWidth();
        } else {
          _timer?.cancel();
          if (gameStarted) {
            showRestartDialog();
          }
        }
      });
    });
    gameStarted = true;
  }

  void showRestartDialog() async {
    bool restart = await showModal<bool>(
          configuration: NonDismissibleModalConfiguration(),
          context: context,
          builder: (context) => AlertDialog(
              title: const Text(
                'Game Start',
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Play'),
                ),
              ],
              actionsAlignment: MainAxisAlignment.center),
        ) ??
        false;
    if (restart) {
      setState(() {
        batteryWidth = 150;
        _durationController.text = '';
        gameStarted = true;
      });
      saveDurationAndWidth();
    } else {
      setState(() {
        batteryWidth = 150;
      });
    }
  }

  void resetDurationAndWidth() {
    setState(() {
      batteryWidth = 150;
      durationInput = 0;
      durationLeft = 0;
      _durationController.text = '';
      gameStarted = false;
    });
    saveDurationAndWidth();
  }

  void saveDurationAndWidth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('batteryWidth', batteryWidth.isNaN ? 0 : batteryWidth);
    prefs.setInt('durationInput', durationInput);
    prefs.setInt('durationLeft', durationLeft);
  }

  void loadSavedDurationAndWidth({bool isRestart = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      batteryWidth = prefs.getDouble('batteryWidth') ?? 150;
      durationInput = prefs.getInt('durationInput') ?? 0;
      durationLeft = prefs.getInt('durationLeft') ?? 0;
      if (durationLeft == 0) {
        durationInput = 0;
        _durationController.clear();
      } else {
        _durationController.text = durationInput.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double percentage = (batteryWidth / 150 * 100);
    String batteryPercentage = percentage.toStringAsFixed(0);
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width / 4.4,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 5),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                              color: Colors.black,
                            ),
                            height: 25,
                            width: 155,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 5),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            color: Colors.grey[400],
                          ),
                          height: 65,
                          width: 150,
                        ),
                        Container(
                          constraints: const BoxConstraints(minWidth: 0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            color: Colors.green,
                          ),
                          width: batteryWidth,
                          height: 65,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 5),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            color: Colors.transparent,
                          ),
                          height: 65,
                          width: 150,
                        ),
                      ],
                    ),
                    Text(
                      percentage > 0 ? '$batteryPercentage%' : '0%',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_durationController.text.isNotEmpty) {
                          startTimer();
                        } else {
                          setState(() {
                            invalidPlayTime = true;
                          });
                        }
                      },
                      child: const SizedBox(
                        width: 65,
                        child: Text(
                          'Play',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        resetDurationAndWidth();
                        setState(() {
                          invalidPlayTime = false;
                        });
                      },
                      child: const SizedBox(
                        width: 65,
                        child: Text(
                          'Reset',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextField(
              controller: _durationController,
              onChanged: (value) => setState(() {
                invalidPlayTime = false;
              }),
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: invalidPlayTime ? null : 'Play Time',
                labelStyle: const TextStyle(color: Colors.black),
                hintText: 'Enter Play Hour',
                hintStyle: TextStyle(
                    color: invalidPlayTime ? Colors.red : Colors.grey),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 5,
                    color: invalidPlayTime ? Colors.red : Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 5,
                    color: invalidPlayTime ? Colors.red : Colors.black,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 5,
                    color: invalidPlayTime ? Colors.red : Colors.black,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 5,
                    color: invalidPlayTime ? Colors.red : Colors.black,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 5,
                    color: invalidPlayTime ? Colors.red : Colors.black,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 5,
                    color: invalidPlayTime ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

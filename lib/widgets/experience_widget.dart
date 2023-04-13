// ignore_for_file: use_build_context_synchronously

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExperienceWidget extends StatefulWidget {
  final bool startExp;

  const ExperienceWidget({super.key, required this.startExp});

  @override
  State<ExperienceWidget> createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<ExperienceWidget> {
  int expPoints = 0;
  DateTime? birthday;

  @override
  void initState() {
    super.initState();
    loadExpPoints();
    loadBirthday();
  }

  void loadExpPoints() async {
    final prefs = await SharedPreferences.getInstance();
    final expPoints = prefs.getInt('expPoints');
    if (expPoints != null) {
      setState(() {
        this.expPoints = expPoints;
      });
    }
  }

  void saveExpPoints(int expPoints) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('expPoints', expPoints);
  }

  void loadBirthday() async {
    final prefs = await SharedPreferences.getInstance();
    final birthday = prefs.getInt('birthday');
    if (birthday != null) {
      setState(() {
        this.birthday = DateTime.fromMillisecondsSinceEpoch(birthday);
      });
    }
  }

  void saveBirthday(DateTime birthday) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('birthday', birthday.millisecondsSinceEpoch);
  }

  int calculateExpPoints(DateTime birthday) {
    final now = DateTime.now();
    int age = now.year - birthday.year;
    if (now.month < birthday.month ||
        (now.month == birthday.month && now.day < birthday.day)) {
      age--;
    }
    return age;
  }

  void setExp() {
    showModal(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Experience'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final initialDate = birthday ?? DateTime.now();
                    final newDate = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (newDate != null) {
                      setState(() {
                        birthday = newDate;
                        expPoints = calculateExpPoints(newDate);
                        saveBirthday(birthday!);
                        saveExpPoints(expPoints);
                        loadExpPoints();
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  child: Text(birthday == null
                      ? 'Choose your birthday'
                      : DateFormat('EEEE, d MMMM y').format(birthday!)),
                ),
                const SizedBox(height: 18),
                TextButton.icon(
                  onPressed: () async {
                    await clearSharedPreferences();
                    setState(() {
                      birthday = null;
                      expPoints = 0;
                      loadBirthday();
                    });
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Reset All Settings',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      expPoints = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width / 17),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  curve: Curves.decelerate,
                  height: 30,
                  width: widget.startExp
                      ? ((expPoints / 100) *
                          (MediaQuery.of(context).size.width -
                              (MediaQuery.of(context).size.width / 17)))
                      : 0,
                  decoration: const BoxDecoration(color: Colors.yellow),
                ),
              ],
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.menu_rounded),
              color: Colors.black,
              onPressed: () => setExp(),
            ),
          ],
        ),
      ),
    );
  }
}

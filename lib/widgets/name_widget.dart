import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NameWidget extends StatefulWidget {
  const NameWidget({super.key});

  @override
  State<NameWidget> createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  late TextEditingController _controller;
  String? gamerID;

  @override
  void initState() {
    super.initState();
    loadGamerID();
    _controller = TextEditingController();
  }

  Future<void> loadGamerID() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      gamerID = prefs.getString('name');
      _controller.text = gamerID ?? '';
    });
  }

  Future<void> saveGamerID(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
      height: (MediaQuery.of(context).size.height / 5) / 2,
      width: MediaQuery.of(context).size.width / 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: _controller,
          onChanged: (value) => saveGamerID(value),
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            labelText: 'Gamer ID',
            labelStyle: TextStyle(color: Colors.black),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 5,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

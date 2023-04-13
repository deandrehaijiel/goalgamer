// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:goalgamer/components/components.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String _apiKey = '';
  String _city = '';
  final String _url = 'https://api.weatherapi.com/v1/current.json';

  String? _temperature;
  String? _condition;
  String? _icon;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    loadApiKeyAndCity();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void enterApiKeyAndCity() {
    showModal(
      configuration: NonDismissibleModalConfiguration(),
      context: context,
      builder: (BuildContext context) {
        if (_apiKey.isNotEmpty) {
          return AlertDialog(
            title: Row(
              children: const [
                Icon(Icons.warning_amber_rounded),
                SizedBox(width: 12),
                Text('Remove API key and City'),
              ],
            ),
            content: const Text(
              'All weather information will be removed.',
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    child: const Text('Remove'),
                    onPressed: () {
                      setState(() {
                        _apiKey = '';
                      });
                      saveApiKeyAndCity();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: const Text('Enter Weather API API key and City'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    // You can save the API key in a state variable here
                    _apiKey = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'API key',
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    // You can save the City in a state variable here
                    _city = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'City',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    child: const Text('OK'),
                    onPressed: () {
                      saveApiKeyAndCity();
                      _fetchWeather();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  void saveApiKeyAndCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('WeatherApiKey', _apiKey);
    prefs.setString('city', _city);
  }

  void loadApiKeyAndCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiKey = prefs.getString('WeatherApiKey') ?? '';
      _city = prefs.getString('city') ?? '';
    });

    if (_apiKey.isNotEmpty && _city.isNotEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        // Call _fetchWeather after setting the state
        _fetchWeather();
      });

      // Call _fetchWeather every 30 minutes
      _timer = Timer.periodic(const Duration(minutes: 30), (timer) {
        _fetchWeather();
      });
    }
  }

  Future<void> _fetchWeather() async {
    final response = await http.post(
      Uri.parse('$_url?key=$_apiKey&q=$_city&aqi=yes'),
    );

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Text(
                    'Failed to fetch weather information: ${response.statusCode}.',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const Icon(Icons.warning_rounded, color: Colors.white)
            ],
          ),
        ),
      );
    }

    final dynamic decoded = json.decode(response.body);

    setState(() {
      _temperature = decoded['current']['temp_c'].toString();
      _condition = decoded['current']['condition']['text'].toString();
      _icon = decoded['current']['condition']['icon'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.black, width: 3),
          right: BorderSide(color: Colors.black, width: 3),
          bottom: BorderSide(color: Colors.black, width: 3),
        ),
      ),
      height: (MediaQuery.of(context).size.height / 5) / 2,
      width: MediaQuery.of(context).size.width / 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: (_temperature != null && _condition != null && _icon != null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    splashRadius: 0.1,
                    onPressed: () => enterApiKeyAndCity(),
                    icon: _apiKey.isEmpty
                        ? const Icon(Icons.account_circle_rounded,
                            color: Colors.black)
                        : const Icon(Icons.logout_rounded, color: Colors.black),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Temperature: $_temperature°C',
                            style: const TextStyle(color: Colors.black),
                          ),
                          Text(
                            'Condition: $_condition',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => _fetchWeather(),
                      child: Image.network('https:$_icon'))
                ],
              )
            : _apiKey.isNotEmpty
                ? Center(
                    child: LoadingAnimationWidget.beat(
                      color: Colors.black,
                      size: 40,
                    ),
                  )
                : Center(
                    child: IconButton(
                      splashRadius: 0.1,
                      onPressed: () => enterApiKeyAndCity(),
                      icon: _apiKey.isEmpty
                          ? const Icon(Icons.account_circle_rounded,
                              color: Colors.black)
                          : const Icon(Icons.logout_rounded,
                              color: Colors.black),
                    ),
                  ),
      ),
    );
  }
}

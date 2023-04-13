// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/components.dart';

class CurrencyConverterWidget extends StatefulWidget {
  final Function toggleMarketWidget;
  const CurrencyConverterWidget({Key? key, required this.toggleMarketWidget})
      : super(key: key);

  @override
  _CurrencyConverterWidgetState createState() =>
      _CurrencyConverterWidgetState();
}

class _CurrencyConverterWidgetState extends State<CurrencyConverterWidget>
    with SingleTickerProviderStateMixin {
  String apiKey = '';
  String _apiKey = '';

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  double _convertedAmount = 0.0;

  bool _swapFromTo = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    loadApiKey();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
      reverseDuration: const Duration(milliseconds: 375),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void enterApiKey() {
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
                Text('Remove API key'),
              ],
            ),
            content: const Text(
              'All currency conversion data will be removed.',
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
                      _amountController.clear();
                      _fromController.clear();
                      _toController.clear();
                      setState(() {
                        _convertedAmount = 0.0;
                        _apiKey = '';
                      });
                      saveApiKey();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: const Text('Enter Exchange Rates API key'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    // You can save the API key in a state variable here
                    apiKey = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'API key',
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
                      setState(() {
                        _apiKey = apiKey;
                      });
                      saveApiKey();
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

  void saveApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ExchangeRatesApiKey', _apiKey);
  }

  void loadApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiKey = prefs.getString('ExchangeRatesApiKey') ?? '';
    });
  }

  void _convertCurrency() async {
    final amount = _amountController.text;
    final fromCurrency = _fromController.text.toUpperCase();
    final toCurrency = _toController.text.toUpperCase();
    if (amount.isEmpty || fromCurrency.isEmpty || toCurrency.isEmpty) {
      setState(() {
        _convertedAmount = 0.0;
      });
    } else {
      final url = Uri.parse(
          'https://api.apilayer.com/exchangerates_data/convert?from=$fromCurrency&to=$toCurrency&amount=$amount');
      final response = await http.get(
        url,
        headers: {
          'apikey': _apiKey,
        },
      );
      final responseBody = json.decode(response.body);
      final result = responseBody['result']?.toDouble() ?? 0.0;
      setState(() {
        _convertedAmount = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width / 4.2,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Currency Converter',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyle(color: Colors.black),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 5,
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 5,
                          color: Colors.black,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 5,
                          color: Colors.black,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 5,
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 5,
                          color: Colors.black,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onChanged: (_) => _convertCurrency(),
                    enabled: _apiKey
                        .isNotEmpty, // Disable the text field if _apiKey is empty
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: _fromController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          labelText: 'From',
                          labelStyle: TextStyle(color: Colors.black),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        onChanged: (_) => _convertCurrency(),
                        enabled: _apiKey
                            .isNotEmpty, // Disable the text field if _apiKey is empty
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _apiKey.isNotEmpty
                          ? InkWell(
                              borderRadius: BorderRadius.circular(30),
                              onTap: () => setState(() {
                                _swapFromTo = !_swapFromTo;
                                if (_swapFromTo) {
                                  _controller.forward();
                                } else {
                                  _controller.reverse();
                                }
                                // Swap the values of the from and to text fields
                                String fromValue = _fromController.text;
                                _fromController.text = _toController.text;
                                _toController.text = fromValue;
                                // Update the converted amount
                                _convertCurrency();
                              }),
                              child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle: _controller.value *
                                        (-pi / 180) *
                                        (_swapFromTo ? 180 : 180),
                                    child: const Icon(
                                      Icons
                                          .keyboard_double_arrow_right_outlined,
                                      color: Colors.black,
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Icon(
                              Icons.keyboard_double_arrow_right_outlined,
                              color: Colors.grey,
                            ),
                    ),
                    Flexible(
                      child: TextField(
                        style: const TextStyle(color: Colors.black),
                        controller: _toController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          labelText: 'To',
                          labelStyle: TextStyle(color: Colors.black),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        onChanged: (_) => _convertCurrency(),
                        enabled: _apiKey
                            .isNotEmpty, // Disable the text field if _apiKey is empty
                      ),
                    ),
                  ],
                ),
                Text(
                  '$_convertedAmount\n${_toController.text.toUpperCase()}',
                  style: const TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: MaterialButton(
              onPressed: () => setState(() {
                widget.toggleMarketWidget();
              }),
              child: const Text(
                'Back to Finances',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () => enterApiKey(),
              child: _apiKey.isEmpty
                  ? const Icon(Icons.account_circle_rounded,
                      color: Colors.white)
                  : const Icon(Icons.logout_rounded, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

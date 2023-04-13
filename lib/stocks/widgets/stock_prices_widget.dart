// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/components.dart';

class StockPricesWidget extends StatefulWidget {
  const StockPricesWidget({super.key});

  @override
  _StockPricesWidgetState createState() => _StockPricesWidgetState();
}

class _StockPricesWidgetState extends State<StockPricesWidget>
    with SingleTickerProviderStateMixin {
  String _apiKey = '';
  String apiKey = '';
  final String _url = 'https://www.alphavantage.co/query';

  Map<String, double> _stockPrices = {};

  final TextEditingController _controller = TextEditingController();
  final _scrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<double> _animationFade;

  bool _isNotEmpty = false;

  @override
  void initState() {
    super.initState();
    loadApiKey();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
      reverseDuration: const Duration(milliseconds: 0),
    );

    _animationFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.decelerate,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
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
              'All stocks data will be removed.',
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
                      _stockPrices = {};
                      setState(() {
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
            title: const Text('Enter Alpha Vantage API key'),
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
    prefs.setString('AlphaVantageApiKey', _apiKey);
  }

  void loadApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiKey = prefs.getString('AlphaVantageApiKey') ?? '';
    });
  }

  Future<void> _fetchStockPrices() async {
    final symbols = _controller.text
        .toUpperCase()
        .replaceAll(',', ' ')
        .split(' ')
        .where((s) => s.isNotEmpty)
        .map((s) => s.trim())
        .toList();

    _controller.clear();

    for (String symbol in symbols) {
      final url = Uri.parse(
          '$_url?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$_apiKey');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final globalQuote = data['Global Quote'];
        if (globalQuote != null) {
          final price = double.tryParse(globalQuote['05. price']);
          if (price != null) {
            setState(() {
              _stockPrices[symbol] = price;
            });
          }
        }
      } else {
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
                      'Failed to fetch stock price: ${response.statusCode}.',
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 3,
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width / 4.2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Prices',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: FadingEdgeScrollView.fromSingleChildScrollView(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _stockPrices.keys.map((symbol) {
                        final price = _stockPrices[symbol];
                        return ClipRect(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              symbol,
                              style: const TextStyle(color: Colors.black),
                            ),
                            subtitle: price != null
                                ? AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        price.toString(),
                                        textStyle: const TextStyle(
                                            color: Colors.black),
                                        speed: const Duration(milliseconds: 84),
                                      ),
                                    ],
                                    isRepeatingAnimation: false,
                                    displayFullTextOnTap: true,
                                  )
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FadeTransition(
                opacity: _animationFade,
                child: Row(
                  children: [
                    IconButton(
                      splashRadius: 0.1,
                      onPressed: () {
                        enterApiKey();
                      },
                      icon: _apiKey.isEmpty
                          ? const Icon(Icons.account_circle_rounded,
                              color: Colors.black)
                          : const Icon(Icons.logout_rounded,
                              color: Colors.black),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onSubmitted: (value) => _fetchStockPrices(),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              _isNotEmpty = true;
                            });
                          } else {
                            setState(() {
                              _isNotEmpty = false;
                            });
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Stock Symbols (,)',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'AAPL, GOOG,',
                          hintStyle: TextStyle(color: Colors.grey),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 5, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 5, color: Colors.black),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 5, color: Colors.black),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 5, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 5, color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 5, color: Colors.black),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        enabled: _apiKey
                            .isNotEmpty, // Disable the text field if _apiKey is empty
                      ),
                    ),
                    _isNotEmpty
                        ? IconButton(
                            splashRadius: 0.1,
                            onPressed: _fetchStockPrices,
                            icon: const Icon(Icons.attach_money_rounded,
                                color: Colors.black),
                          )
                        : IconButton(
                            splashRadius: 0.1,
                            onPressed: () {},
                            icon: const Icon(Icons.attach_money_rounded,
                                color: Colors.grey),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

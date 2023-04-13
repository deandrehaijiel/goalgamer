// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class QuoteWidget extends StatefulWidget {
  const QuoteWidget({Key? key}) : super(key: key);

  @override
  _QuoteWidgetState createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  late Future<String> _quoteOfTheDay;
  late Future<String> _author;

  final _scrollController = ScrollController();

  Future<String> _fetchQuoteOfTheDay() async {
    final response = await http.get(
      Uri.parse('https://favqs.com/api/qotd'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['quote']['body'];
    } else {
      throw Exception('Failed to load quote of the day');
    }
  }

  Future<String> _fetchQuoteOfTheDayAuthor() async {
    final response = await http.get(
      Uri.parse('https://favqs.com/api/qotd'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['quote']['author'];
    } else {
      throw Exception('Failed to load quote of the day author');
    }
  }

  @override
  void initState() {
    super.initState();
    _quoteOfTheDay = _fetchQuoteOfTheDay();
    _author = _fetchQuoteOfTheDayAuthor();
  }

  Future<void> _refreshQuoteOfTheDay() async {
    setState(() {
      _quoteOfTheDay = _fetchQuoteOfTheDay();
      _author = _fetchQuoteOfTheDayAuthor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: Future.wait([_quoteOfTheDay, _author])
          .then((values) => values.join(' - ')),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Row(
              children: [
                const Text('Failed to load quote of the day'),
                IconButton(
                  onPressed: _refreshQuoteOfTheDay,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            );
          } else {
            return InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: _refreshQuoteOfTheDay,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width / 5,
                child: FadingEdgeScrollView.fromSingleChildScrollView(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Text(
                      snapshot.data!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
              ),
            );
          }
        } else {
          return LoadingAnimationWidget.beat(
            color: Colors.black,
            size: 40,
          );
        }
      },
    );
  }
}

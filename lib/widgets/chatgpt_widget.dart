// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:goalgamer/components/non_dimissible_modal.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatGPTWidget extends StatefulWidget {
  const ChatGPTWidget({super.key});

  @override
  _ChatGPTWidgetState createState() => _ChatGPTWidgetState();
}

class _ChatGPTWidgetState extends State<ChatGPTWidget> {
  final TextEditingController _textController = TextEditingController();
  List<String> responses = [];
  final _scrollController = ScrollController();
  String apiKey = '';

  @override
  void initState() {
    super.initState();
    loadApiKey();
    loadConversationHistory();
  }

  void enterApiKey() {
    showModal(
      configuration: NonDismissibleModalConfiguration(),
      context: context,
      builder: (BuildContext context) {
        if (apiKey.isNotEmpty) {
          return AlertDialog(
            title: Row(
              children: const [
                Icon(Icons.warning_amber_rounded),
                SizedBox(width: 12),
                Text('Remove API key'),
              ],
            ),
            content: const Text(
              'All conversation history will be deleted.',
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
                      apiKey = '';
                      responses = [];
                      saveApiKey();
                      saveConversationHistory();
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: const Text('Enter ChatGPT API key'),
            content: TextField(
              obscureText: true,
              onChanged: (value) {
                // You can save the API key in a state variable here
                apiKey = value;
              },
              decoration: const InputDecoration(
                hintText: 'API key',
              ),
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
                      saveApiKey();
                      setState(() {});
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
    prefs.setString('chatGPTApiKey', apiKey);
  }

  void loadApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      apiKey = prefs.getString('chatGPTApiKey') ?? '';
    });
  }

  void saveConversationHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('conversationHistory', responses);
  }

  void loadConversationHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      responses = prefs.getStringList('conversationHistory') ?? [];
    });
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      responses.add(message);
    });

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'user',
            'content': message,
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final responseText = jsonResponse['choices'][0]['message']['content'];
      setState(() {
        responses.add(responseText);
      });
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
                    'Request failed with status: ${response.statusCode}.',
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

    saveConversationHistory();
  }

  void _deleteMessage(int index) {
    setState(() {
      responses.removeAt(index);
    });

    saveConversationHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width / 1.8,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: FadingEdgeScrollView.fromSingleChildScrollView(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: responses.asMap().entries.map(
                        (entry) {
                          final index = entry.key;
                          final responseText = entry.value;
                          return ClipRect(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Slidable(
                                key: ValueKey(responseText),
                                endActionPane: ActionPane(
                                  extentRatio: 0.1,
                                  motion: const StretchMotion(),
                                  children: [
                                    // delete button
                                    SlidableAction(
                                      onPressed: (context) {
                                        _deleteMessage(index);
                                      },
                                      label: 'Delete',
                                      backgroundColor: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                      padding: const EdgeInsets.all(0),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onLongPress: () {
                                          final data =
                                              ClipboardData(text: responseText);
                                          Clipboard.setData(data);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: Colors.grey[400],
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(30),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24,
                                                      vertical: 30),
                                              content: const Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 18),
                                                  child: Text(
                                                    'Copied to Clipboard',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              responseText,
                                              textStyle: const TextStyle(
                                                  color: Colors.black),
                                              speed: const Duration(
                                                  milliseconds: 21),
                                            ),
                                          ],
                                          isRepeatingAnimation: false,
                                          displayFullTextOnTap: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  splashRadius: 0.1,
                  onPressed: () => enterApiKey(),
                  icon: apiKey.isEmpty
                      ? const Icon(Icons.account_circle_rounded,
                          color: Colors.black)
                      : const Icon(Icons.logout_rounded, color: Colors.black),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: (value) {
                      if (apiKey.isNotEmpty) {
                        _sendMessage(_textController.text);
                        _textController.clear();
                      } else {
                        _sendMessage(_textController.text);
                        _textController.clear();
                      }
                    },
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Ask ChatGPT',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: '...',
                      hintStyle: TextStyle(color: Colors.grey),
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
                    enabled: apiKey
                        .isNotEmpty, // Disable the text field if _apiKey is empty
                  ),
                ),
                const SizedBox(width: 12),
                apiKey.isNotEmpty
                    ? IconButton(
                        splashRadius: 0.1,
                        onPressed: () {
                          _sendMessage(_textController.text);
                          _textController.clear();
                        },
                        icon: const Icon(Icons.send, color: Colors.black),
                      )
                    : IconButton(
                        splashRadius: 0.1,
                        onPressed: () {},
                        icon: const Icon(Icons.send, color: Colors.grey),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

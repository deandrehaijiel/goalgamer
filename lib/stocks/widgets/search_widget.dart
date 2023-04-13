import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api.dart';
import '../state/state.dart';
import 'stocks.dart';

class SearchWidget extends StatefulWidget {
  final String apiKey;
  final Function toggleMarketWidget;

  const SearchWidget(
      {Key? key, required this.apiKey, required this.toggleMarketWidget})
      : super(key: key);

  @override
  State<SearchWidget> createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  late final ValueNotifier<String> _apiKey;

  @override
  void initState() {
    super.initState();
    _apiKey = ValueNotifier<String>(widget.apiKey);
  }

  void _updateApiKey(String newApiKey) {
    setState(() {
      _apiKey.value = newApiKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width / 4.2,
      child: BlocProvider.value(
        value: StocksAppStateCubit(StocksApi(StocksApi.buildDefaultHttpClient(_apiKey.value))),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              MaterialButton(
                onPressed: () => setState(() {
                  widget.toggleMarketWidget();
                }),
                child: const Text(
                  'Back to Finances',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SearchFormWidget(onApiKeyChanged: _updateApiKey),
            ],
          ),
        ),
      ),
    );
  }
}

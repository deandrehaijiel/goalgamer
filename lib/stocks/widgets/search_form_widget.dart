// ignore_for_file: implementation_imports, must_be_immutable

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/components.dart';
import '../helper/helper.dart';
import '../models/models.dart';
import '../state/state.dart';
import 'stocks.dart';

class SearchFormWidget extends StatefulWidget {
  final ValueNotifier<String> _apiKey = ValueNotifier<String>('');
  final Function(String) onApiKeyChanged;

  SearchFormWidget({
    Key? key,
    required this.onApiKeyChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchFormWidgetState();
}

class SearchFormWidgetState extends State<SearchFormWidget>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late final GetCandlesRequest? recentQuery =
      context.read<StocksAppStateCubit>().state.recentQuery;

  late DateTime? startDate = recentQuery?.from;
  late DateTime? endDate = recentQuery?.to;
  late final _symbolController =
      TextEditingController(text: recentQuery?.symbol);

  String _apiKey = '';

  bool _searchWidget = true;

  bool _accountIcon = true;

  late AnimationController _animationController;
  late Animation<double> _animationFade;

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

  @override
  Widget build(BuildContext context) {
    if (_searchWidget) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 4.2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Chart',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    buildStartDateSelect(context),
                    buildEndDateSelect(context),
                    FadeTransition(
                      opacity: _animationFade,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildEnterApiKeyButton(),
                          buildSymbolEntry(),
                          buildSubmitButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const StockPricesWidget(),
        ],
      );
    } else {
      return StockChartWidget(
        toggleSearchWidget: () {
          setState(() {
            _searchWidget = true;
          });
        },
      );
    }
  }

  IconButton buildEnterApiKeyButton() {
    return IconButton(
      splashRadius: 0.1,
      onPressed: () {
        enterApiKey();
      },
      icon: _accountIcon
          ? const Icon(Icons.account_circle_rounded, color: Colors.black)
          : const Icon(Icons.logout_rounded, color: Colors.black),
    );
  }

  void enterApiKey() {
    showModal(
      configuration: NonDismissibleModalConfiguration(),
      context: context,
      builder: (BuildContext context) {
        if (!_accountIcon) {
          return AlertDialog(
            title: Row(
              children: const [
                Icon(Icons.warning_amber_rounded),
                SizedBox(width: 12),
                Text('Remove API key'),
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
                    child: const Text('Remove'),
                    onPressed: () {
                      setState(() {
                        widget._apiKey.value = '';
                        widget.onApiKeyChanged(widget._apiKey.value);
                        _apiKey = '';
                        startDate = null;
                        endDate = null;
                        _symbolController.clear();
                        _accountIcon = true;
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
            title: const Text('Enter Finnhub API key'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder(
                  valueListenable: widget._apiKey,
                  builder: (context, apiKey, _) => TextField(
                    obscureText: true,
                    onChanged: (value) {
                      // You can save the API key in a state variable here
                      apiKey = value;
                      widget._apiKey.value = apiKey;
                    },
                    decoration: const InputDecoration(
                      hintText: 'API key',
                    ),
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
                        widget.onApiKeyChanged(widget._apiKey.value);
                        _apiKey = widget._apiKey.value;
                        _accountIcon = false;
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
    prefs.setString('FinnhubApiKey', _apiKey);
  }

  void loadApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiKey = prefs.getString('FinnhubApiKey') ?? '';
      widget._apiKey.value = _apiKey;
      widget.onApiKeyChanged(_apiKey);

      if (_apiKey.isNotEmpty) {
        _accountIcon = false;
      }
    });
  }

  IconButton buildSubmitButton() {
    return _symbolController.text.isNotEmpty
        ? IconButton(
            splashRadius: 0.1,
            onPressed: onSubmit,
            icon: const Icon(
              Icons.candlestick_chart_rounded,
              color: Colors.black,
            ),
          )
        : IconButton(
            splashRadius: 0.1,
            onPressed: () {},
            icon: const Icon(
              Icons.candlestick_chart_rounded,
              color: Colors.grey,
            ),
          );
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final bloc = context.read<StocksAppStateCubit>();
      bloc.loadCandles(
        _symbolController.text.trim(),
        startDate!,
        endDate!,
      );
      setState(() {
        _searchWidget = false;
      });
    }
  }

  FormField<DateTime> buildEndDateSelect(BuildContext context) {
    return FormField<DateTime>(
      initialValue: endDate,
      validator: (endDate) {
        if (endDate == null) {
          return "End date is required";
        }

        if (startDate != null && startDate!.isAfter(endDate)) {
          return "End date must be after the start date";
        }
        return null;
      },
      builder: (field) {
        final textColor = field.hasError ? Colors.red : Colors.black;
        return ListTile(
          enabled:
              _apiKey.isNotEmpty, // Disable the text field if _apiKey is empty
          subtitle: Text(
            endDate?.dayMonthYearLabel ?? "End date",
            style: TextStyle(color: textColor),
          ),
          title: Text(
            field.errorText ?? "Plot to the end of this day",
            style: TextStyle(color: textColor),
          ),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: endDate ?? DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (date != null) {
              setState(() => endDate = date
                  .add(const Duration(hours: 23, minutes: 59, seconds: 59)));
              field.didChange(date);
            }

            field.validate();
          },
          trailing: Icon(Icons.date_range, color: textColor),
        );
      },
    );
  }

  FormField<DateTime> buildStartDateSelect(BuildContext context) {
    return FormField<DateTime>(
      initialValue: startDate,
      validator: (startDate) {
        if (startDate == null) {
          return "Start date is required";
        }

        if (endDate != null && startDate.isAfter(endDate!)) {
          return "Start date must be before the end date";
        }
        return null;
      },
      builder: (field) {
        final textColor = field.hasError ? Colors.red : Colors.black;
        return ListTile(
          enabled:
              _apiKey.isNotEmpty, // Disable the text field if _apiKey is empty
          subtitle: Text(
            startDate?.dayMonthYearLabel ?? "Start date",
            style: TextStyle(color: textColor),
          ),
          title: Text(
            field.errorText ?? "Plot from the start of this day",
            style: TextStyle(color: textColor),
          ),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate:
                  startDate ?? DateTime.now().subtract(const Duration(days: 7)),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (date != null) {
              setState(() => startDate = date);
              field.didChange(date);
            }
            field.validate();
          },
          trailing: Icon(Icons.date_range, color: textColor),
        );
      },
    );
  }

  Expanded buildSymbolEntry() {
    return Expanded(
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          labelText: 'Stock Symbol',
          labelStyle: TextStyle(color: Colors.black),
          hintText: 'AAPL',
          hintStyle: TextStyle(color: Colors.grey),
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
        controller: _symbolController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled:
            _apiKey.isNotEmpty, // Disable the text field if _apiKey is empty
      ),
    );
  }
}

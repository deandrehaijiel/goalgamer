import 'dart:math';

import 'package:flutter/material.dart';

import '../crypto/presentation/widgets/widgets.dart';
import '../forex/widgets/forex.dart';
import '../stocks/widgets/stocks.dart';

class MarketWidget extends StatefulWidget {
  const MarketWidget({super.key});

  @override
  State<MarketWidget> createState() => _MarketWidgetState();
}

class _MarketWidgetState extends State<MarketWidget> {
  final String _stockApiKey = '';

  String showWidget = 'MarketWidget';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetToShow;
    if (showWidget == 'MarketWidget') {
      widgetToShow = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () => setState(() {
              showWidget = 'StocksWidget';
            }),
            icon: Transform.rotate(
              angle: 180 * pi / 180,
              child: const Icon(
                Icons.waterfall_chart_rounded,
                color: Colors.black,
                size: 42,
              ),
            ),
            label: const Text(
              'Stocks',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
            ),
          ),
          TextButton.icon(
            onPressed: () => setState(() {
              showWidget = 'CryptoWidget';
            }),
            icon: const Icon(
              Icons.currency_bitcoin_rounded,
              color: Colors.black,
              size: 42,
            ),
            label: const Text(
              'Crypto',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
            ),
          ),
          TextButton.icon(
            onPressed: () => setState(() {
              showWidget = 'ForexWidget';
            }),
            icon: const Icon(
              Icons.currency_exchange_rounded,
              color: Colors.black,
              size: 42,
            ),
            label: const Text(
              'Forex',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            style: ButtonStyle(
              overlayColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
            ),
          )
        ],
      );
    } else if (showWidget == 'StocksWidget') {
      widgetToShow = SearchWidget(
        apiKey: _stockApiKey,
        toggleMarketWidget: () {
          setState(() {
            showWidget = 'MarketWidget';
          });
        },
      );
    } else if (showWidget == 'CryptoWidget') {
      widgetToShow = RatingsWidget(
        toggleMarketWidget: () {
          setState(() {
            showWidget = 'MarketWidget';
          });
        },
      );
    } else {
      widgetToShow = CurrencyConverterWidget(
        toggleMarketWidget: () {
          setState(() {
            showWidget = 'MarketWidget';
          });
        },
      );
    }

    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width / 4.2,
      child: widgetToShow,
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'change_price_triangle.dart';
import 'sparkline_widget.dart';

class CoinInfoBox extends StatelessWidget {
  final String coinName;
  final num currentPrice, priceChangePercentage, marketCap;
  final String imageUrl;
  final int coinIndex;
  final String symbol;
  final List<double>? sparkline;
  final List<FlSpot>? flSpotList;
  final String fiatCurrency;
  const CoinInfoBox({
    super.key,
    required this.coinName,
    required this.currentPrice,
    required this.imageUrl,
    required this.coinIndex,
    required this.symbol,
    required this.priceChangePercentage,
    required this.marketCap,
    required this.fiatCurrency,
    this.sparkline,
    this.flSpotList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.network(
                    imageUrl,
                    width: 30,
                    height: 30,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: coinName.length > 12
                            ? Text(
                                coinName.replaceRange(
                                  12,
                                  coinName.length,
                                  '...',
                                ),
                                style: const TextStyle(color: Colors.black),
                              )
                            : Text(
                                coinName,
                                style: const TextStyle(color: Colors.black),
                              ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            child: Text(
                              '${coinIndex + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            symbol.toUpperCase(),
                            style: const TextStyle(color: Colors.black),
                          ),
                          ChangePriceTriangle(
                            priceChangePercentage: priceChangePercentage,
                            fontSize: 18,
                            textStyle: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              height: 40,
              child: AbsorbPointer(
                absorbing: true,
                child: SparklineWidget(
                  sparkline: sparkline,
                  flSpotList: flSpotList,
                  showBarArea: false,
                  pricePercentage: priceChangePercentage,
                ),
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${currentPrice.toStringAsFixed(2)} ${fiatCurrency.toUpperCase()}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    marketCap > 1000000000000
                        ? ' ${'MCap ${(marketCap / 1000000000).toStringAsFixed(2)} ${fiatCurrency.toUpperCase()}'} T'
                        : ' ${'MCap ${(marketCap / 1000000000).toStringAsFixed(2)} ${fiatCurrency.toUpperCase()}'} Bn',
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

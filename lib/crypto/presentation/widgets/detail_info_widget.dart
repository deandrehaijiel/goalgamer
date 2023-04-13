// ignore_for_file: library_private_types_in_public_api

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../components/change_price_triangle.dart';
import '../components/detail_sparkline_widget.dart';

class DetailInfoWidget extends StatefulWidget {
  final Function toggleRatingsWidget;
  final String coinName;
  final num currentPrice, priceChangePercentage, marketCap;
  final String imageUrl;
  final int coinIndex;
  final String symbol;
  final List<double>? sparkline;
  final List<FlSpot>? flSpotList;
  final String fiatCurrency;
  const DetailInfoWidget({
    required this.coinName,
    required this.currentPrice,
    required this.priceChangePercentage,
    required this.marketCap,
    required this.imageUrl,
    required this.coinIndex,
    required this.symbol,
    required this.sparkline,
    required this.flSpotList,
    required this.fiatCurrency,
    Key? key,
    required this.toggleRatingsWidget,
  }) : super(key: key);

  @override
  _DetailInfoWidgetState createState() => _DetailInfoWidgetState();
}

class _DetailInfoWidgetState extends State<DetailInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width / 4.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                IconButton(
                  splashRadius: 0.1,
                  onPressed: () => setState(() {
                    widget.toggleRatingsWidget();
                  }),
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.black),
                ),
                Image.network(
                  widget.imageUrl,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.symbol.toUpperCase(),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  child: Text(
                    '${widget.coinIndex + 1}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.coinName,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${widget.currentPrice} ${widget.fiatCurrency.toUpperCase()}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    ChangePriceTriangle(
                      priceChangePercentage: widget.priceChangePercentage,
                      fontSize: 24,
                      textStyle: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 430,
            child: DetailSparklineWidget(
              showBarArea: true,
              sparkline: widget.sparkline,
              flSpotList: widget.flSpotList,
              pricePercentage: widget.priceChangePercentage,
            ),
          ),
        ],
      ),
    );
  }
}

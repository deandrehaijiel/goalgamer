import 'dart:math' as math;

import 'package:flutter/material.dart';

class ChangePriceTriangle extends StatelessWidget {
  final num priceChangePercentage, fontSize;
  final TextStyle textStyle;

  const ChangePriceTriangle({
    super.key,
    required this.priceChangePercentage,
    required this.fontSize,
    required this.textStyle,
  });
  @override
  Widget build(BuildContext context) {
    if (priceChangePercentage > 0) {
      return Row(
        children: <Widget>[
          Container(
            transform: Matrix4.translationValues(0, 1.8, 0),
            child: Transform.rotate(
              angle: -90 * math.pi / 180,
              child: const Icon(
                Icons.play_arrow,
                color: Colors.green,
                size: 24,
              ),
            ),
          ),
          Text(
            '${priceChangePercentage.toStringAsFixed(2)}%',
            style: textStyle,
          ),
        ],
      );
    } else {
      if (priceChangePercentage < 0) {
        return Row(
          children: <Widget>[
            Container(
              transform: Matrix4.translationValues(0, -1, 0),
              child: Transform.rotate(
                angle: 90 * math.pi / 180,
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.red,
                  size: 24,
                ),
              ),
            ),
            Text(
              '${priceChangePercentage.abs().toStringAsFixed(2)}%',
              style: textStyle,
            ),
          ],
        );
      } else {
        return Row(
          children: <Widget>[
            Container(
              transform: Matrix4.translationValues(0, -1, 0),
              child: Transform.rotate(
                angle: 90 * math.pi / 180,
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.grey,
                  size: 24,
                ),
              ),
            ),
            Text(
              '${priceChangePercentage.abs().toStringAsFixed(2)}%',
              style: textStyle,
            ),
          ],
        );
      }
    }
  }
}

import 'package:flutter/material.dart';

import 'components.dart';

class BlurWidget extends StatelessWidget {
  const BlurWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: CustomPaint(
          foregroundPainter: CircleBlurPainter(
        circleWidth: 60,
        blurSigma: 6,
        color: Colors.grey[400] as Color,
      )),
    );
  }
}

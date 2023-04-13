import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 7.2,
      width: MediaQuery.of(context).size.width / 7.2,
      child: Lottie.asset('assets/working.json'),
    );
  }
}

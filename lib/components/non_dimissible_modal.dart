import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class NonDismissibleModalConfiguration extends ModalConfiguration {
  NonDismissibleModalConfiguration()
      : super(
          barrierDismissible: false,
          barrierLabel: null,
          barrierColor: Colors.black54,
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
        );

  @override
  Widget transitionBuilder(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeScaleTransition(
      animation: animation,
      child: child,
    );
  }
}

import 'package:flutter/material.dart';

class RotationYTransition extends AnimatedWidget {
  final Widget child;
  final Animation<double> turns;
  final Alignment alignment;

  const RotationYTransition({
    Key? key,
    required this.turns,
    required this.child,
    this.alignment = Alignment.center,
  }) : super(key: key, listenable: turns);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final double radians =
        animation.value * 3.1415926535897932; // Pi radians = 180 degrees

    return Transform(
      alignment: alignment,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // Perspective
        ..rotateY(radians), // Rotate around Y-axis
      child: child,
    );
  }
}

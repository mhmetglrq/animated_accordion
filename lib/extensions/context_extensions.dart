import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Returns the height of the device
  double get height => MediaQuery.sizeOf(this).height;

  /// Returns the width of the device
  double get width => MediaQuery.sizeOf(this).width;

  /// Returns 1% of the screen height
  double get lowValue => height * 0.01;

  /// Default value is 2% of the screen height
  double get defaultValue => height * 0.02;

  /// Returns 5% of the screen height
  double get highValue => height * 0.05;

  /// Returns 10% of the screen height
  double get veryhighValue1x => height * 0.1;

  /// Returns 20% of the screen height
  double get veryhighValue2x => height * 0.2;

  /// Returns 30% of the screen height
  double get veryhighValue3x => height * 0.3;

  /// Returns 40% of the screen height
  double get veryhighValue4x => height * 0.4;

  /// Returns 50% of the screen height
  double get veryhighValue5x => height * 0.5;

  double dynamicWidth(double val) => width * val;
  double dynamicHeight(double val) => height * val;
}

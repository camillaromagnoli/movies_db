import 'package:flutter/material.dart';

class AppBorderRadius {
  AppBorderRadius._();

  /// borderRadius `0.0 px`
  static const BorderRadius none = BorderRadius.zero;

  /// borderRadius `4.0 px`
  static const BorderRadius small = BorderRadius.all(Radius.circular(4.0));

  /// borderRadius `8.0 px`
  static const BorderRadius medium = BorderRadius.all(Radius.circular(8.0));

  /// borderRadius `16.0 px`
  static const BorderRadius large = BorderRadius.all(Radius.circular(16.0));
}

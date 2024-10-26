import 'package:flutter/cupertino.dart';

class AppDimensions {
  static const p8 = 8.0;
  static const p12 = 12.0;
  static const p16 = 16.0;
  static const p24 = 24.0;
  static const p32 = 32.0;

  static BorderRadius br({
    double topLeft = 0.0,
    double topRight = 0.0,
    double bottomLeft = 0.0,
    double bottomRight = 0.0,
  }) =>
      BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      );

  static BorderRadius brAll({
    double all = 0.0,
  }) =>
      BorderRadius.all(Radius.circular(all));
}

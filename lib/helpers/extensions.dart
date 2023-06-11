import 'package:flutter/cupertino.dart';

class Dimensions {
  static double RadiusSmall = 10;
  static double RadiusMedium = 20;
  static double RadiusLarge = 30;
}

extension MyBorderRadius on num {
  BorderRadiusGeometry get border => BorderRadius.circular(toDouble());
  SizedBox get w => SizedBox(width: toDouble());
  SizedBox get h => SizedBox(height: toDouble());
}

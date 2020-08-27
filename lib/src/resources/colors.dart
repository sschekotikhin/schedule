import 'package:flutter/material.dart';
import 'dart:math';

class MaterialColorGenerator {
  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(
      color.value, 
      {
        50: tintColor(color, 0.5),
        100: tintColor(color, 0.4),
        200: tintColor(color, 0.3),
        300: tintColor(color, 0.2),
        400: tintColor(color, 0.1),
        500: tintColor(color, 0),
        600: tintColor(color, -0.1),
        700: tintColor(color, -0.2),
        800: tintColor(color, -0.3),
        900: tintColor(color, -0.4),
      }
    );
  }

  static int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1
  );
}


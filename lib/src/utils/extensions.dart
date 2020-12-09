import 'package:flutter/material.dart';

extension GradientExt on Gradient {
  Shader defaultShader(Rect bounds) =>
      createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
}

extension ColorExt on Color {
  Gradient get toGradient => LinearGradient(colors: [this, this]);
}

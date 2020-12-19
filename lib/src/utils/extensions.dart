import 'dart:core';

import 'package:flutter/material.dart';

extension GradientExt on Gradient {
  Shader defaultShader(Rect bounds) =>
      createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
}

extension ColorExt on Color {
  Gradient get toGradient => LinearGradient(colors: [this, this]);
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int i, E e) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}

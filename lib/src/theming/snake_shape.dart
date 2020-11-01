import 'package:flutter/material.dart';

class SnakeShape {
  /// Contains a custom view shape
  final ShapeBorder shape;

  ///Used to custom shapes to change bounds:
  ///
  /// if [centered] is true  -> element bounds are square with default padding
  /// if [centered] is false -> element bounds fills the container size
  final bool centered;

  /// Used internal for distinction defined and custom shapes
  final SnakeShapeType type;

  final double height;

  const SnakeShape(
      {@required this.shape,
      this.centered = true,
      this.height = kBottomNavigationBarHeight})
      : type = SnakeShapeType.custom;

  const SnakeShape._internal(
      {this.shape, this.type, this.centered, this.height});

  SnakeShape copyWith({ShapeBorder shape, bool centered, double height}) {
    return SnakeShape._internal(
      shape: shape ?? this.shape,
      type: this.type,
      centered: centered ?? this.centered,
      height: height.clamp(0, kBottomNavigationBarHeight) ?? this.height,
    );
  }

  static const SnakeShape circle = SnakeShape._internal(
    shape: null,
    type: SnakeShapeType.circle,
    centered: false,
    height: kBottomNavigationBarHeight,
  );

  static const SnakeShape rectangle = SnakeShape._internal(
    shape: null,
    type: SnakeShapeType.rectangle,
    centered: false,
    height: kBottomNavigationBarHeight,
  );

  static const SnakeShape indicator = SnakeShape._internal(
    shape: null,
    type: SnakeShapeType.indicator,
    centered: false,
    height: 4.0,
  );
}

enum SnakeShapeType { circle, rectangle, indicator, custom }

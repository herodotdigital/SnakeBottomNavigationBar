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

  SnakeShape({@required this.shape, this.centered = true})
      : type = SnakeShapeType.custom;

  const SnakeShape._internal({this.shape, this.type, this.centered});

  SnakeShape copyWith({ShapeBorder shape, bool centered}) {
    return SnakeShape._internal(
      shape: shape ?? this.shape,
      type: this.type,
      centered: centered ?? this.centered,
    );
  }

  static const SnakeShape circle = SnakeShape._internal(
      shape: null, type: SnakeShapeType.circle, centered: false);

  static const SnakeShape rectangle = SnakeShape._internal(
      shape: null, type: SnakeShapeType.rectangle, centered: false);

  static const SnakeShape indicator = SnakeShape._internal(
      shape: null, type: SnakeShapeType.indicator, centered: false);
}

enum SnakeShapeType { circle, rectangle, indicator, custom }

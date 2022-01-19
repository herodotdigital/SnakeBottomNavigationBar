import 'package:flutter/material.dart';

class SnakeShape {
  /// Contains a custom view shape
  final ShapeBorder? shape;

  ///Used to custom shapes to change bounds:
  ///
  /// if [centered] is true  -> element bounds are square with default padding
  /// if [centered] is false -> element bounds fills the container size
  final bool? centered;

  /// Used internal for distinction defined and custom shapes
  final SnakeShapeType? type;

  /// Snake view padding for each tile
  final EdgeInsets padding;

  ///Snake view height
  final double? height;

  const SnakeShape({
    required this.shape,
    this.centered = true,
    this.padding = EdgeInsets.zero,
    this.height,
  }) : type = SnakeShapeType.custom;

  const SnakeShape._({
    this.shape,
    this.type,
    this.centered,
    this.padding = EdgeInsets.zero,
    this.height,
  });

  SnakeShape copyWith({
    ShapeBorder? shape,
    bool? centered,
    EdgeInsets? padding,
  }) {
    return SnakeShape._(
      shape: shape ?? this.shape,
      type: type,
      centered: centered ?? this.centered,
      padding: padding ?? this.padding,
    );
  }

  static const SnakeShape circle = SnakeShape._(
      shape: null,
      type: SnakeShapeType.circle,
      centered: false,
      padding: EdgeInsets.all(4));

  static const SnakeShape rectangle = SnakeShape._(
      shape: null, type: SnakeShapeType.rectangle, centered: false);

  static const SnakeShape indicator = SnakeShape._(
      shape: null, type: SnakeShapeType.indicator, centered: false);
}

enum SnakeShapeType { circle, rectangle, indicator, custom }

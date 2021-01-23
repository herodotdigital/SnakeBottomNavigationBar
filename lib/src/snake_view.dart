import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/src/theming/snake_bottom_bar_theme.dart';
import 'package:flutter_snake_navigationbar/src/theming/snake_shape.dart';

import 'selection_notifier.dart';

class SnakeView extends StatefulWidget {
  final int itemsCount;
  final double widgetEdgePadding;
  final SelectionNotifier notifier;
  final Duration animationDuration;
  final Duration delayTransition;
  final Curve snakeCurve;
  final double indicatorHeight;
  final double height;

  const SnakeView({
    required this.itemsCount,
    required this.widgetEdgePadding,
    required this.notifier,
    this.animationDuration = const Duration(milliseconds: 200),
    this.delayTransition = const Duration(milliseconds: 50),
    this.snakeCurve = Curves.easeInOut,
    this.indicatorHeight = 4,
    required this.height,
  });

  @override
  _SnakeViewState createState() => _SnakeViewState();
}

class _SnakeViewState extends State<SnakeView> {
  double left = 0;
  int snakeSize = 1;
  int? currentIndex;
  Orientation? orientation;
  double? oneItemWidth;
  double? prevItemWidth;

  bool get isRTL => Directionality.of(context) == TextDirection.rtl;

  void addListener() {
    widget.notifier.addListener(() {
      if (widget.notifier.lastIndex < widget.notifier.currentIndex) {
        _goRight();
      } else if (widget.notifier.lastIndex > widget.notifier.currentIndex) {
        _goLeft();
      }
      currentIndex = widget.notifier.currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = SnakeBottomBarTheme.of(context)!;
    oneItemWidth =
        (MediaQuery.of(context).size.width - widget.widgetEdgePadding) /
            widget.itemsCount;

    addListener();

    if (currentIndex == null ||
        currentIndex != widget.notifier.currentIndex ||
        orientation != MediaQuery.of(context).orientation ||
        prevItemWidth != oneItemWidth) {
      left = oneItemWidth! * widget.notifier.currentIndex;
      currentIndex = widget.notifier.currentIndex;
      orientation = MediaQuery.of(context).orientation;
      prevItemWidth = oneItemWidth;
    }

    final viewPadding = theme.snakeShape.type == SnakeShapeType.circle ||
            theme.snakeShape.centered!
        ? () {
            final maxSize = math.min(oneItemWidth!, widget.height);
            return EdgeInsets.symmetric(
                  vertical: (widget.height - maxSize) / 2,
                  horizontal: (oneItemWidth! - maxSize) / 2,
                ) +
                theme.snakeShape.padding;
          }()
        : theme.snakeShape.padding;

    final snakeViewWidth = oneItemWidth! * snakeSize - viewPadding.horizontal;

    return AnimatedPositioned(
      left: isRTL ? null : left,
      right: isRTL ? left : null,
      duration: widget.animationDuration,
      curve: widget.snakeCurve,
      child: AnimatedContainer(
        margin: viewPadding,
        curve: widget.snakeCurve,
        duration: widget.animationDuration,
        width: snakeViewWidth,
        height: _snakeViewHeight(theme),
        child: Material(
          shape: _snakeShape(theme),
          clipBehavior: Clip.antiAlias,
          child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: SnakeBottomBarTheme.of(context)!.snakeGradient),
          ),
        ),
      ),
    );
  }

  double _snakeViewHeight(SnakeBottomBarThemeData theme) {
    if (theme.snakeShape.type == SnakeShapeType.indicator) {
      return widget.indicatorHeight;
    }
    if (theme.snakeShape.type == SnakeShapeType.circle) {
      final maxSize = math.min(oneItemWidth!, widget.height);
      return maxSize - theme.snakeShape.padding.vertical;
    } else {
      return widget.height - theme.snakeShape.padding.vertical;
    }
  }

  ShapeBorder? _snakeShape(SnakeBottomBarThemeData theme) {
    switch (theme.snakeShape.type) {
      case SnakeShapeType.circle:
        return _getRoundShape(_snakeViewHeight(theme) / 2);

      default:
        return theme.snakeShape.shape;
    }
  }

  void _goRight() {
    final newSnakeSize =
        widget.notifier.currentIndex + 1 - widget.notifier.lastIndex;
    setState(() => snakeSize = newSnakeSize);
    Future.delayed(
      widget.animationDuration + widget.delayTransition,
      () => setState(() {
        snakeSize = 1;
        left = oneItemWidth! * widget.notifier.currentIndex;
      }),
    );
  }

  void _goLeft() {
    final newSnakeSize =
        (widget.notifier.currentIndex - widget.notifier.lastIndex).abs();
    setState(() {
      left = oneItemWidth! * widget.notifier.currentIndex;
      snakeSize = newSnakeSize + 1;
    });
    Future.delayed(
      widget.animationDuration + widget.delayTransition,
      () => setState(() => snakeSize = 1),
    );
  }

  ShapeBorder _getRoundShape(double radius) => RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      );
}

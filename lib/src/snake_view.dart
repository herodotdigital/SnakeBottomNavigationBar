import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/src/snake_shape.dart';
import 'selection_notifier.dart';

class SnakeView extends StatefulWidget {
  final int itemsCount;
  final SnakeShape shape;
  final Color snakeColor;
  final double widgetEdgePadding;
  final SelectionNotifier notifier;
  final Duration animationDuration;
  final Duration delayTransition;
  final Curve snakeCurve;
  final double circlePadding;
  final double indicatorHeight;
  final bool showSelectedLabels;

  const SnakeView({
    this.itemsCount,
    this.shape,
    this.widgetEdgePadding,
    this.notifier,
    this.animationDuration = const Duration(milliseconds: 200),
    this.delayTransition = const Duration(milliseconds: 50),
    this.snakeCurve = Curves.easeInOut,
    this.circlePadding = 4,
    this.indicatorHeight = 4,
    this.showSelectedLabels,
    this.snakeColor,
  });

  @override
  _SnakeViewState createState() => _SnakeViewState();
}

class _SnakeViewState extends State<SnakeView> {
  double left = 0;
  int snakeSize = 1;
  int currentIndex;

  @override
  Widget build(BuildContext context) {
    double oneItemWidth = (MediaQuery.of(context).size.width - widget.widgetEdgePadding) / widget.itemsCount;

    widget.notifier.addListener(() {
      int newSnakeSize;
      if (widget.notifier.lastIndex < widget.notifier.currentIndex) {
        //region going right
        newSnakeSize = widget.notifier.currentIndex + 1 - widget.notifier.lastIndex;
        setState(() => snakeSize = newSnakeSize);
        Future.delayed(
            widget.animationDuration + widget.delayTransition,
            () => setState(() {
                  snakeSize = 1;
                  left = oneItemWidth * widget.notifier.currentIndex;
                }));
        //endregion
      } else if (widget.notifier.lastIndex > widget.notifier.currentIndex) {
        //region going left
        newSnakeSize = (widget.notifier.currentIndex - widget.notifier.lastIndex).abs();
        setState(() {
          left = oneItemWidth * widget.notifier.currentIndex;
          snakeSize = newSnakeSize + 1;
        });
        Future.delayed(widget.animationDuration + widget.delayTransition, () => setState(() => snakeSize = 1));
        //endregion
      } else {
        //the same place
        newSnakeSize = snakeSize;
      }
      currentIndex = widget.notifier.currentIndex;
    });

    if (currentIndex == null || currentIndex != widget.notifier.currentIndex) {
      left = oneItemWidth * widget.notifier.currentIndex;
      currentIndex = widget.notifier.currentIndex;
    }

    EdgeInsets viewPadding = widget.shape.type == SnakeShapeType.circle || widget.shape.centered
        ? EdgeInsets.symmetric(
            vertical: widget.circlePadding,
            horizontal: (oneItemWidth - (kBottomNavigationBarHeight - widget.circlePadding * 2)) / 2,
          )
        : EdgeInsets.zero;

    double snakeViewWidth = widget.shape.type == SnakeShapeType.circle || widget.shape.type == SnakeShapeType.custom
        ? oneItemWidth * snakeSize - (viewPadding.left + viewPadding.right)
        : oneItemWidth * snakeSize;

    double snakeViewHeight;
    ShapeBorder snakeShape;

    switch (widget.shape.type) {
      case SnakeShapeType.circle:
        snakeViewHeight = kBottomNavigationBarHeight - widget.circlePadding * 2;
        snakeShape = _getRoundShape(snakeViewHeight / 2);
        break;

      case SnakeShapeType.indicator:
        snakeViewHeight = widget.indicatorHeight;
        snakeShape = widget.shape.shape;
        break;

      case SnakeShapeType.rectangle:
        snakeViewHeight = kBottomNavigationBarHeight;
        snakeShape = widget.shape.shape;
        break;

      case SnakeShapeType.custom:
        snakeViewHeight = widget.shape.centered ? kBottomNavigationBarHeight - widget.circlePadding * 2 : kBottomNavigationBarHeight;
        snakeShape = widget.shape.shape;
        break;
    }

    return AnimatedPositioned(
      left: left,
      duration: widget.animationDuration,
      curve: widget.snakeCurve,
      child: Padding(
        padding: viewPadding,
        child: AnimatedContainer(
          curve: widget.snakeCurve,
          duration: widget.animationDuration,
          width: snakeViewWidth,
          height: snakeViewHeight,
          child: Material(shape: snakeShape, color: widget.snakeColor),
        ),
      ),
    );
  }

  ShapeBorder _getRoundShape(double radius) => RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radius)));
}

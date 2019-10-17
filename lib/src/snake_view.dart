import 'package:flutter/material.dart';
import 'selection_notifier.dart';
import 'snake_bar_widget.dart';

class SnakeView extends StatefulWidget {
  final int itemsCount;
  final SnakeType shape;
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

    EdgeInsets viewPadding = widget.shape == SnakeType.circle
        ? EdgeInsets.symmetric(
            vertical: widget.circlePadding,
            horizontal: (oneItemWidth - (kBottomNavigationBarHeight - widget.circlePadding * 2)) / 2,
          )
        : EdgeInsets.zero;

    double snakeViewWidth =
        widget.shape == SnakeType.circle ? oneItemWidth * snakeSize - (viewPadding.left + viewPadding.right) : oneItemWidth * snakeSize;

    double snakeViewHeight;
    BoxDecoration snakeShape;

    if (widget.shape == SnakeType.circle) {
      snakeViewHeight = kBottomNavigationBarHeight - widget.circlePadding * 2;
      snakeShape = _getRoundDecoration();
    } else if (widget.shape == SnakeType.rectangle) {
      snakeViewHeight = kBottomNavigationBarHeight;
      snakeShape = _getSquareDecoration();
    } else {
      snakeViewHeight = widget.indicatorHeight;
      snakeShape = _getIndicatorDecoration();
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
          decoration: snakeShape,
        ),
      ),
    );
  }

  BoxDecoration _getRoundDecoration() {
    return BoxDecoration(
      color: widget.snakeColor,
      borderRadius: BorderRadius.all(
        Radius.circular(kBottomNavigationBarHeight),
      ),
    );
  }

  BoxDecoration _getSquareDecoration() {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      color: widget.snakeColor,
    );
  }

  BoxDecoration _getIndicatorDecoration() {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      color: widget.snakeColor,
    );
  }
}

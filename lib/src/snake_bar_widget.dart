import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/src/snake_shape.dart';

import 'selection_notifier.dart';
import 'snake_bar_style.dart';
import 'snake_item_tile.dart';
import 'snake_view.dart';

class SnakeNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;

  /// If [SnakeBarStyle.floating] this color is
  /// used as background color of shaped view.
  /// If [SnakeBarStyle.pinned] this color just
  /// a background color of whole [SnakeNavigationBar] view
  final Gradient backgroundGradient;

  /// This color represents a SnakeView and unselected
  /// Icon and label color
  final Gradient selectedColor;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  final bool showSelectedLabels;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  final bool showUnselectedLabels;

  /// The index into [items] for the current active [BottomNavigationBarItem].
  final int currentIndex;

  ///You can specify custom elevation shadow color
  final Color shadowColor;

  /// Defines the [SnakeView] shape and behavior of a [SnakeNavigationBar].
  ///
  /// See documentation for [SnakeShape] for information on the
  /// meaning of different shapes.
  ///
  /// Default is [SnakeShape.circle]
  final SnakeShape snakeShape;

  /// Defines the layout and behavior of a [SnakeNavigationBar].
  ///
  /// See documentation for [SnakeBarStyle] for information on the
  /// meaning of different styles.
  ///
  /// Default is [SnakeBarStyle.pinned]
  final SnakeBarStyle style;

  /// You can define custom [ShapeBorder] with padding and elevation to [SnakeNavigationBar]
  final ShapeBorder shape;
  final EdgeInsets padding;
  final double elevation;

  /// Called when one of the [items] is pressed.
  final ValueChanged<int> onPositionChanged;

  final SelectionNotifier _notifier;

  SnakeNavigationBar({
    Color snakeColor,
    Gradient snakeGradient,
    Color backgroundColor,
    Gradient backgroundGradient,
    bool showSelectedLabels = false,
    this.showUnselectedLabels = false,
    this.items,
    this.currentIndex = 0,
    this.shape,
    this.padding = EdgeInsets.zero,
    this.elevation = 0,
    this.onPositionChanged,
    this.style = SnakeBarStyle.pinned,
    this.snakeShape = SnakeShape.circle,
    this.shadowColor = Colors.black,
  })  : assert((snakeGradient == null && snakeColor != null) ||
            (snakeGradient != null && snakeColor == null) ||
            (snakeGradient == null && snakeColor == null)),
        assert((backgroundColor == null && backgroundGradient != null) ||
            (backgroundColor != null && backgroundGradient == null) ||
            (backgroundColor == null && backgroundGradient == null)),
        this.backgroundGradient = backgroundGradient ??
            LinearGradient(colors: [
              backgroundColor ?? Colors.white,
              backgroundColor ?? Colors.white
            ]),
        selectedColor = snakeGradient ??
            LinearGradient(colors: [
              snakeColor ?? Colors.black,
              snakeColor ?? Colors.black
            ]),
        _notifier = SelectionNotifier(currentIndex, onPositionChanged),
        showSelectedLabels =
            (snakeShape.type == SnakeShapeType.circle && showSelectedLabels)
                ? false
                : showSelectedLabels;

  @override
  Widget build(BuildContext context) {
    List<SnakeItemTile> tiles = items
        .map((item) => SnakeItemTile(
              item.icon,
              item.title,
              showSelectedLabels,
              showUnselectedLabels,
              items.indexOf(item),
              backgroundGradient,
              selectedColor,
              _notifier,
              snakeShape.type == SnakeShapeType.indicator
                  ? SelectionStyle.opacity
                  : SelectionStyle.color,
            ))
        .toList();

    return AnimatedPadding(
      padding: padding,
      duration: kThemeChangeDuration,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            left: false,
            right: false,
            child: Material(
              shadowColor: shadowColor,
              elevation: elevation,
              clipBehavior: Clip.antiAlias,
              shape: shape,
              child: Container(
                decoration: BoxDecoration(gradient: backgroundGradient),
                height: kBottomNavigationBarHeight,
                child: Stack(
                  children: [
                    SnakeView(
                      itemsCount: items.length,
                      shape: snakeShape,
                      showSelectedLabels: showSelectedLabels,
                      widgetEdgePadding: padding.left + padding.right,
                      snakeColor: selectedColor,
                      notifier: _notifier,
                    ),
                    Row(children: tiles),
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            height: style == SnakeBarStyle.pinned
                ? MediaQuery.of(context).padding.bottom
                : 0,
            decoration: BoxDecoration(gradient: backgroundGradient),
            duration: kThemeChangeDuration,
          ),
        ],
      ),
    );
  }
}

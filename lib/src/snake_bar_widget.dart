import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/src/theming/snake_shape.dart';

import 'selection_notifier.dart';
import 'theming/selection_style.dart';
import 'theming/snake_bar_behaviour.dart';
import 'snake_item_tile.dart';
import 'snake_view.dart';
import 'theming/snake_bottom_bar_theme.dart';
import 'utils/extensions.dart';

class SnakeNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;

  /// If [SnakeBarBehaviour.floating] this color is
  /// used as background color of shaped view.
  /// If [SnakeBarBehaviour.pinned] this color just
  /// a background color of whole [SnakeNavigationBar] view
  final Gradient backgroundGradient;

  /// This color represents a SnakeView and unselected
  /// Icon and label color
  final Gradient snakeViewGradient;

  /// This color represents a selected Icon color
  final Gradient selectedItemGradient;

  /// This color represents a unselected Icon color
  final Gradient unselectedItemGradient;

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
  /// See documentation for [SnakeBarBehaviour] for information on the
  /// meaning of different styles.
  ///
  /// Default is [SnakeBarBehaviour.pinned]
  final SnakeBarBehaviour behaviour;

  /// You can define custom [ShapeBorder] with padding and elevation to [SnakeNavigationBar]
  final ShapeBorder shape;
  final EdgeInsets padding;
  final double elevation;

  /// Called when one of the [items] is pressed.
  final ValueChanged<int> onTap;

  final SelectionNotifier _notifier;

  final SelectionStyle _selectionStyle;

  SnakeNavigationBar._(
    this._selectionStyle, {
    this.snakeViewGradient,
    this.backgroundGradient,
    this.selectedItemGradient,
    this.unselectedItemGradient,
    bool showSelectedLabels = false,
    this.showUnselectedLabels = false,
    this.items,
    this.currentIndex = 0,
    this.shape,
    this.padding = EdgeInsets.zero,
    this.elevation = 0,
    this.onTap,
    this.behaviour = SnakeBarBehaviour.pinned,
    this.snakeShape = SnakeShape.circle,
    this.shadowColor = Colors.black,
  })  : this._notifier = SelectionNotifier(currentIndex, onTap),
        this.showSelectedLabels =
            (snakeShape.type == SnakeShapeType.circle && showSelectedLabels)
                ? false
                : showSelectedLabels;

  factory SnakeNavigationBar.color({
    Color snakeViewColor,
    Color backgroundColor,
    Color selectedItemColor,
    Color unselectedItemColor,
    bool showSelectedLabels = false,
    bool showUnselectedLabels = false,
    List<BottomNavigationBarItem> items,
    int currentIndex = 0,
    ShapeBorder shape,
    EdgeInsets padding = EdgeInsets.zero,
    double elevation = 0.0,
    ValueChanged<int> onTap,
    SnakeBarBehaviour behaviour = SnakeBarBehaviour.pinned,
    SnakeShape snakeShape = SnakeShape.circle,
    Color shadowColor = Colors.black,
  }) {
    return SnakeNavigationBar._(
      SelectionStyle.color,
      snakeViewGradient: snakeViewColor?.toGradient,
      backgroundGradient: backgroundColor?.toGradient,
      selectedItemGradient: selectedItemColor?.toGradient,
      unselectedItemGradient: unselectedItemColor?.toGradient,
      showSelectedLabels: showUnselectedLabels ?? false,
      showUnselectedLabels: showUnselectedLabels ?? false,
      items: items,
      currentIndex: currentIndex ?? 0,
      shape: shape,
      padding: padding ?? EdgeInsets.zero,
      elevation: elevation ?? 0.0,
      onTap: onTap,
      behaviour: behaviour ?? SnakeBarBehaviour.pinned,
      snakeShape: snakeShape ?? SnakeShape.circle,
      shadowColor: shadowColor ?? Colors.black,
    );
  }

  factory SnakeNavigationBar.gradient({
    Gradient snakeViewGradient,
    Gradient backgroundGradient,
    Gradient selectedItemGradient,
    Gradient unselectedItemGradient,
    bool showSelectedLabels = false,
    bool showUnselectedLabels = false,
    List<BottomNavigationBarItem> items,
    int currentIndex = 0,
    ShapeBorder shape,
    EdgeInsets padding = EdgeInsets.zero,
    double elevation = 0.0,
    ValueChanged<int> onTap,
    SnakeBarBehaviour behaviour = SnakeBarBehaviour.pinned,
    SnakeShape snakeShape = SnakeShape.circle,
    Color shadowColor = Colors.black,
  }) {
    return SnakeNavigationBar._(
      SelectionStyle.gradient,
      snakeViewGradient: snakeViewGradient,
      backgroundGradient: backgroundGradient,
      selectedItemGradient: selectedItemGradient,
      unselectedItemGradient: unselectedItemGradient,
      showSelectedLabels: showUnselectedLabels ?? false,
      showUnselectedLabels: showUnselectedLabels ?? false,
      items: items,
      currentIndex: currentIndex ?? 0,
      shape: shape,
      padding: padding ?? EdgeInsets.zero,
      elevation: elevation ?? 0.0,
      onTap: onTap,
      behaviour: behaviour ?? SnakeBarBehaviour.pinned,
      snakeShape: snakeShape ?? SnakeShape.circle,
      shadowColor: shadowColor ?? Colors.black,
    );
  }

  SnakeBottomBarThemeData _createTheme(BuildContext context) {
    var theme = BottomNavigationBarTheme.of(context);
    return SnakeBottomBarThemeData(
      snakeGradient:
          snakeViewGradient ?? Theme.of(context).accentColor?.toGradient,
      backgroundGradient: backgroundGradient ??
          theme.backgroundColor?.toGradient ??
          Theme.of(context).cardColor?.toGradient,
      selectedItemGradient: selectedItemGradient ??
          theme.selectedItemColor?.toGradient ??
          Theme.of(context).cardColor?.toGradient,
      unselectedItemGradient: unselectedItemGradient ??
          theme.unselectedItemColor?.toGradient ??
          Theme.of(context).accentColor?.toGradient,
      showSelectedLabels:
          showSelectedLabels ?? theme.showSelectedLabels ?? true,
      showUnselectedLabels:
          showUnselectedLabels ?? theme.showUnselectedLabels ?? true,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<SnakeItemTile> tiles = items
        .map((item) => SnakeItemTile(
              item.icon,
              item.label,
              items.indexOf(item),
              _notifier,
              _selectionStyle,
              snakeShape.type == SnakeShapeType.indicator,
            ))
        .toList();

    var theme = _createTheme(context);
    return SnakeBottomBarTheme(
      data: theme,
      child: AnimatedPadding(
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
                color: Colors.transparent,
                shape: shape,
                child: Container(
                  decoration: BoxDecoration(gradient: theme.backgroundGradient),
                  height: kBottomNavigationBarHeight,
                  child: Stack(
                    children: [
                      SnakeView(
                        itemsCount: items.length,
                        shape: snakeShape,
                        widgetEdgePadding: padding.left + padding.right,
                        notifier: _notifier,
                      ),
                      Row(children: tiles),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              height: behaviour == SnakeBarBehaviour.pinned
                  ? MediaQuery.of(context).padding.bottom
                  : 0,
              decoration: BoxDecoration(gradient: theme.backgroundGradient),
              duration: kThemeChangeDuration,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/src/theming/snake_shape.dart';

import 'selection_notifier.dart';
import 'snake_item_tile.dart';
import 'snake_view.dart';
import 'theming/selection_style.dart';
import 'theming/snake_bar_behaviour.dart';
import 'theming/snake_bottom_bar_theme.dart';
import 'utils/extensions.dart';

class SnakeNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem>? items;

  /// If [SnakeBarBehaviour.floating] this color is
  /// used as background color of shaped view.
  /// If [SnakeBarBehaviour.pinned] this color just
  /// a background color of whole [SnakeNavigationBar] view
  final Gradient? backgroundGradient;

  /// This color represents a SnakeView and unselected
  /// Icon and label color
  final Gradient? snakeViewGradient;

  /// This color represents a selected Icon color
  final Gradient? selectedItemGradient;

  /// This color represents a unselected Icon color
  final Gradient? unselectedItemGradient;

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
  final ShapeBorder? shape;
  final EdgeInsets padding;
  final double elevation;

  /// The [TextStyle] of the [BottomNavigationBarItem] labels when they are
  /// selected.
  final TextStyle? selectedLabelStyle;

  /// The [TextStyle] of the [BottomNavigationBarItem] labels when they are not
  /// selected.
  final TextStyle? unselectedLabelStyle;

  /// Called when one of the [items] is pressed.
  final ValueChanged<int>? onTap;

  final SelectionStyle _selectionStyle;

  /// BottomNavigationBar height default is [kBottomNavigationBarHeight]
  final double height;

  SnakeNavigationBar._(
    this._selectionStyle, {
    Key? key,
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
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    required this.height,
  })   : showSelectedLabels =
            (snakeShape.type == SnakeShapeType.circle && showSelectedLabels)
                ? false
                : showSelectedLabels,
        super(key: key);

  factory SnakeNavigationBar.color({
    Key? key,
    Color? snakeViewColor,
    Color? backgroundColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    bool showSelectedLabels = false,
    bool showUnselectedLabels = false,
    List<BottomNavigationBarItem>? items,
    int currentIndex = 0,
    ShapeBorder? shape,
    EdgeInsets padding = EdgeInsets.zero,
    double elevation = 0.0,
    ValueChanged<int>? onTap,
    SnakeBarBehaviour behaviour = SnakeBarBehaviour.pinned,
    SnakeShape snakeShape = SnakeShape.circle,
    Color shadowColor = Colors.black,
    TextStyle? selectedLabelStyle,
    TextStyle? unselectedLabelStyle,
    double? height,
  }) =>
      SnakeNavigationBar._(
        SelectionStyle.color,
        key: key,
        snakeViewGradient: snakeViewColor?.toGradient,
        backgroundGradient: backgroundColor?.toGradient,
        selectedItemGradient: selectedItemColor?.toGradient,
        unselectedItemGradient: unselectedItemColor?.toGradient,
        showSelectedLabels: showSelectedLabels,
        showUnselectedLabels: showUnselectedLabels,
        items: items,
        currentIndex: currentIndex,
        shape: shape,
        padding: padding,
        elevation: elevation,
        onTap: onTap,
        behaviour: behaviour,
        snakeShape: snakeShape,
        shadowColor: shadowColor,
        selectedLabelStyle: selectedLabelStyle,
        unselectedLabelStyle: unselectedLabelStyle,
        height: height ?? kBottomNavigationBarHeight,
      );

  factory SnakeNavigationBar.gradient({
    Key? key,
    Gradient? snakeViewGradient,
    Gradient? backgroundGradient,
    Gradient? selectedItemGradient,
    Gradient? unselectedItemGradient,
    bool showSelectedLabels = false,
    bool showUnselectedLabels = false,
    List<BottomNavigationBarItem>? items,
    int currentIndex = 0,
    ShapeBorder? shape,
    EdgeInsets padding = EdgeInsets.zero,
    double elevation = 0.0,
    ValueChanged<int>? onTap,
    SnakeBarBehaviour behaviour = SnakeBarBehaviour.pinned,
    SnakeShape snakeShape = SnakeShape.circle,
    Color shadowColor = Colors.black,
    TextStyle? selectedLabelStyle,
    TextStyle? unselectedLabelStyle,
    double? height,
  }) =>
      SnakeNavigationBar._(
        SelectionStyle.gradient,
        key: key,
        snakeViewGradient: snakeViewGradient,
        backgroundGradient: backgroundGradient,
        selectedItemGradient: selectedItemGradient,
        unselectedItemGradient: unselectedItemGradient,
        showSelectedLabels: showSelectedLabels,
        showUnselectedLabels: showUnselectedLabels,
        items: items,
        currentIndex: currentIndex,
        shape: shape,
        padding: padding,
        elevation: elevation,
        onTap: onTap,
        behaviour: behaviour,
        snakeShape: snakeShape,
        shadowColor: shadowColor,
        selectedLabelStyle: selectedLabelStyle,
        unselectedLabelStyle: unselectedLabelStyle,
        height: height ?? kBottomNavigationBarHeight,
      );

  SnakeBottomBarThemeData _createTheme(BuildContext context) {
    final theme = BottomNavigationBarTheme.of(context);
    return SnakeBottomBarThemeData(
      snakeGradient:
          snakeViewGradient ?? Theme.of(context).accentColor.toGradient,
      backgroundGradient: backgroundGradient ??
          theme.backgroundColor?.toGradient ??
          Theme.of(context).cardColor.toGradient,
      selectedItemGradient: selectedItemGradient ??
          theme.selectedItemColor?.toGradient ??
          Theme.of(context).cardColor.toGradient,
      unselectedItemGradient: unselectedItemGradient ??
          theme.unselectedItemColor?.toGradient ??
          Theme.of(context).accentColor.toGradient,
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels,
      snakeShape: snakeShape,
      selectionStyle: _selectionStyle,
      selectedLabelStyle: selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SnakeBottomBarTheme(
      data: _createTheme(context),
      child: _SnakeNavigationBar(
        padding: padding,
        elevation: elevation,
        shadowColor: shadowColor,
        shape: shape,
        behaviour: behaviour,
        items: items,
        height: height,
        notifier: SelectionNotifier(currentIndex, onTap),
      ),
    );
  }
}

class _SnakeNavigationBar extends StatelessWidget {
  final EdgeInsets padding;
  final double elevation;
  final double height;
  final Color shadowColor;
  final ShapeBorder? shape;
  final SnakeBarBehaviour behaviour;
  final List<BottomNavigationBarItem>? items;
  final SelectionNotifier notifier;

  const _SnakeNavigationBar({
    Key? key,
    required this.padding,
    required this.elevation,
    required this.shadowColor,
    required this.shape,
    required this.behaviour,
    required this.items,
    required this.notifier,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = SnakeBottomBarTheme.of(context)!;

    final List<Widget> tiles = items!
        .mapIndexed((index, item) => SnakeItemTile(
              icon: item.icon,
              label: item.label,
              position: index,
              isSelected: notifier.currentIndex == index,
              onTap: () => notifier.selectIndex(index),
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
              color: Colors.transparent,
              shape: shape,
              child: AnimatedContainer(
                duration: kThemeChangeDuration,
                decoration: BoxDecoration(gradient: theme.backgroundGradient),
                height: height,
                child: Stack(
                  children: [
                    SnakeView(
                      itemsCount: items!.length,
                      height: height,
                      widgetEdgePadding: padding.left + padding.right,
                      notifier: notifier,
                    ),
                    Row(children: tiles),
                  ],
                ),
              ),
            ),
          ),
          AnimatedContainer(
            height: isPinned ? MediaQuery.of(context).padding.bottom : 0,
            decoration: BoxDecoration(gradient: theme.backgroundGradient),
            duration: kThemeChangeDuration,
          ),
        ],
      ),
    );
  }

  bool get isPinned => behaviour == SnakeBarBehaviour.pinned;
}

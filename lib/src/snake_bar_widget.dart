import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'selection_notifier.dart';
import 'snake_item_tile.dart';
import 'snake_view.dart';

class SnakeNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;

  /// If [SnakeBarStyle.floating] this color is
  /// used as background color of shaped view.
  /// If [SnakeBarStyle.pinned] this color just
  /// a background color of whole [SnakeNavigationBar] view
  final Color backgroundColor;

  /// This color represents a SnakeView and unselected
  /// Icon and label color
  final Color selectedTintColor;

  ///You can setup custom color for selected Icon and label
  final Color selectedIconTintColor;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  final bool showSelectedLabels;

  /// Whether the labels are shown for the selected [BottomNavigationBarItem].
  final bool showUnselectedLabels;

  /// The index into [items] for the current active [BottomNavigationBarItem].
  final int currentIndex;

  /// Defines the [SnakeView] shape and behavior of a [SnakeNavigationBar].
  ///
  /// Default is [SnakeType.circle]
  final SnakeType type;

  /// Defines the layout and behavior of a [SnakeNavigationBar].
  ///
  /// See documentation for [SnakeBarStyle] for information on the
  /// meaning of different styles.
  ///
  /// Default is [SnakeBarStyle.pinned]
  final SnakeBarStyle style;

  /// You can define custom [ShapeBorder] with padding and elevation to [SnakeNavigationBar]
  ///
  /// IMPORTANT You can use custom shape only with [SnakeBarStyle.floating]
  final ShapeBorder shape;
  final EdgeInsets padding;
  final double elevation;

  /// Called when one of the [items] is tapped.
  final ValueChanged<int> onTap;

  final SelectionNotifier notifier;

  SnakeNavigationBar({
    Color selectionColor,
    Color selectedIconColor,
    /// if [SnakeType] is [SnakeType.circle]  showSelectedLabels will be always false
    bool showSelectedLabels = false,
    this.showUnselectedLabels = false,
    this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.type = SnakeType.circle,
    this.shape,
    this.padding = EdgeInsets.zero,
    this.elevation = 0,
    this.onTap,
    this.style = SnakeBarStyle.pinned,
  })  : selectedTintColor = selectionColor ?? Colors.white,
        selectedIconTintColor = selectedIconColor ?? backgroundColor ?? Colors.white,
        notifier = SelectionNotifier(currentIndex, onTap),
        showSelectedLabels = (type == SnakeType.circle && showSelectedLabels) ? false : showSelectedLabels;

  @override
  Widget build(BuildContext context) {
    List<SnakeItemTile> tiles = items
        .map((item) => SnakeItemTile(
              item.icon,
              item.title,
              showSelectedLabels,
              showUnselectedLabels,
              items.indexOf(item),
              selectedIconTintColor,
              selectedTintColor,
              notifier,
              type == SnakeType.indicator ? SelectionStyle.opacity : SelectionStyle.color,
            ))
        .toList();

    return Container(
      padding: padding,
      color: style == SnakeBarStyle.floating ? null : backgroundColor,
      child: SafeArea(
        child: Material(
          elevation: elevation,
          clipBehavior: Clip.antiAlias,
          color: backgroundColor,
          shape: shape,
          child: SizedBox(
            height: kBottomNavigationBarHeight,
            child: Stack(children: [
              SnakeView(
                itemsCount: items.length,
                shape: type,
                showSelectedLabels: showSelectedLabels,
                widgetEdgePadding: padding.left + padding.right,
                snakeColor: selectedTintColor,
                notifier: notifier,
              ),
              Row(children: tiles),
            ]),
          ),
        ),
      ),
    );
  }
}

enum SnakeBarStyle {
  /// use [SnakeBarStyle.floating] style if you want to
  /// separate [SnakeNavigationBar] from bottom side
  floating,

  /// [SnakeBarStyle.pinned] is default [SnakeNavigationBar] style
  /// which is pinned to bottom side
  pinned
}

enum SnakeType { circle, rectangle, indicator }

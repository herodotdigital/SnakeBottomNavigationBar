import 'package:flutter/widgets.dart';

class SnakeBottomBarTheme extends InheritedWidget {
  const SnakeBottomBarTheme({
    Key key,
    @required this.data,
    Widget child,
  })  : assert(data != null),
        super(key: key, child: child);

  final SnakeBottomBarThemeData data;

  static SnakeBottomBarThemeData of(BuildContext context) {
    final SnakeBottomBarTheme bottomNavTheme =
        context.dependOnInheritedWidgetOfExactType<SnakeBottomBarTheme>();
    return bottomNavTheme?.data;
  }

  @override
  bool updateShouldNotify(SnakeBottomBarTheme oldWidget) =>
      data != oldWidget.data;
}

class SnakeBottomBarThemeData {
  final Gradient snakeGradient;
  final Gradient backgroundGradient;
  final Gradient selectedItemGradient;
  final Gradient unselectedItemGradient;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  SnakeBottomBarThemeData({
    @required this.snakeGradient,
    @required this.backgroundGradient,
    @required this.selectedItemGradient,
    @required this.unselectedItemGradient,
    @required this.showSelectedLabels,
    @required this.showUnselectedLabels,
  });
}

import 'package:flutter/widgets.dart';

class SnakeBottomBarTheme extends InheritedWidget {
  const SnakeBottomBarTheme({
    @required this.data,
    Key key,
    Widget child,
  })  : assert(data != null),
        super(key: key, child: child);

  final SnakeBottomBarThemeData data;

  static SnakeBottomBarThemeData of(BuildContext context) {
    final bottomNavTheme = context.dependOnInheritedWidgetOfExactType<SnakeBottomBarTheme>();
    return bottomNavTheme?.data;
  }

  @override
  bool updateShouldNotify(SnakeBottomBarTheme oldWidget) => false;
}

class SnakeBottomBarThemeData {
  final Gradient snakeGradient;
  final Gradient backgroundGradient;
  final Gradient selectedItemGradient;
  final Gradient unselectedItemGradient;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;

  SnakeBottomBarThemeData({
    @required this.snakeGradient,
    @required this.backgroundGradient,
    @required this.selectedItemGradient,
    @required this.unselectedItemGradient,
    @required this.showSelectedLabels,
    @required this.showUnselectedLabels,
    @required this.selectedLabelStyle,
    @required this.unselectedLabelStyle,
  });
}

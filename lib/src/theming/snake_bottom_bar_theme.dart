import 'package:flutter/widgets.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_snake_navigationbar/src/theming/selection_style.dart';

class SnakeBottomBarTheme extends InheritedWidget {
  const SnakeBottomBarTheme({
    required this.data,
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final SnakeBottomBarThemeData data;

  static SnakeBottomBarThemeData? of(BuildContext context) {
    final bottomNavTheme =
        context.dependOnInheritedWidgetOfExactType<SnakeBottomBarTheme>();
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
  final SnakeShape snakeShape;
  final SelectionStyle selectionStyle;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;

  SnakeBottomBarThemeData({
    required this.snakeGradient,
    required this.backgroundGradient,
    required this.selectedItemGradient,
    required this.unselectedItemGradient,
    required this.showSelectedLabels,
    required this.showUnselectedLabels,
    required this.snakeShape,
    required this.selectionStyle,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
  });
}

import 'package:flutter/material.dart';

import '../flutter_snake_navigationbar.dart';
import 'theming/selection_style.dart';
import 'theming/snake_bottom_bar_theme.dart';
import 'utils/extensions.dart';

class SnakeItemTile extends StatelessWidget {
  final Widget? icon;
  final String? label;
  final int? position;
  final bool? isSelected;
  final VoidCallback? onTap;

  const SnakeItemTile({
    Key? key,
    this.icon,
    this.label,
    this.position,
    this.isSelected,
    this.onTap,
  }) : super(key: key);

  bool isIndicatorStyle(SnakeBottomBarThemeData theme) =>
      theme.snakeShape.type == SnakeShapeType.indicator;

  @override
  Widget build(BuildContext context) {
    final theme = SnakeBottomBarTheme.of(context)!;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Container(
            margin: theme.snakeShape.padding,
            child: () {
              if (isSelected!) {
                return theme.showSelectedLabels && label != null
                    ? _getLabeledItem(theme)
                    : _getThemedIcon(theme);
              } else {
                return theme.showUnselectedLabels && label != null
                    ? _getLabeledItem(theme)
                    : _getThemedIcon(theme);
              }
            }(),
          ),
        ),
      ),
    );
  }

  Widget _getLabeledItem(SnakeBottomBarThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getThemedIcon(theme),
        const SizedBox(height: 1),
        _getThemedTitle(theme),
      ],
    );
  }

  Widget _getThemedIcon(SnakeBottomBarThemeData theme) {
    final itemGradient =
        isSelected! ? theme.selectedItemGradient : theme.unselectedItemGradient;
    final iconWidget = theme.selectionStyle == SelectionStyle.gradient
        ? ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: itemGradient.defaultShader,
            child: icon,
          )
        : IconTheme(
            data: IconThemeData(color: itemGradient.colors.first),
            child: icon!,
          );

    return isIndicatorStyle(theme)
        ? Opacity(
            opacity: isSelected! ? 1 : 0.6,
            child: iconWidget,
          )
        : iconWidget;
  }

  Widget _getThemedTitle(SnakeBottomBarThemeData theme) {
    final textTheme =
        (isSelected! ? theme.selectedLabelStyle : theme.unselectedLabelStyle) ??
            const TextStyle();
    final itemGradient =
        isSelected! ? theme.selectedItemGradient : theme.unselectedItemGradient;

    final labelWidget = theme.selectionStyle == SelectionStyle.gradient
        ? ShaderMask(
            shaderCallback: itemGradient.defaultShader,
            child: Text(label ?? '',
                style: textTheme.copyWith(color: Colors.white)),
          )
        : Text(
            label ?? '',
            style: textTheme.copyWith(color: itemGradient.colors.first),
          );

    return isIndicatorStyle(theme)
        ? Opacity(
            opacity: isSelected! ? 1 : 0.6,
            child: labelWidget,
          )
        : labelWidget;
  }
}

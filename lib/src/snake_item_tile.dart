import 'package:flutter/material.dart';

import 'selection_notifier.dart';
import 'theming/selection_style.dart';
import 'theming/snake_bottom_bar_theme.dart';
import 'utils/extensions.dart';

class SnakeItemTile extends StatelessWidget {
  final Widget icon;
  final String label;
  final int position;
  final SelectionNotifier notifier;
  final SelectionStyle selectionStyle;
  final bool isIndicatorStyle;

  const SnakeItemTile(
    this.icon,
    this.label,
    this.position,
    this.notifier,
    this.selectionStyle,
    this.isIndicatorStyle,
  );

  bool get isSelected => notifier.currentIndex == position;

  @override
  Widget build(BuildContext context) {
    final theme = SnakeBottomBarTheme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => notifier.selectIndex(position),
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraint) {
              if (isSelected) {
                return theme.showSelectedLabels
                    ? _getLabeledItem(theme)
                    : _getThemedIcon(theme);
              } else {
                return theme.showUnselectedLabels
                    ? _getLabeledItem(theme)
                    : _getThemedIcon(theme);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _getLabeledItem(SnakeBottomBarThemeData theme) {
    return label != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getThemedIcon(theme),
              const SizedBox(height: 1),
              _getThemedTitle(theme),
            ],
          )
        : _getThemedIcon(theme);
  }

  Widget _getThemedTitle(SnakeBottomBarThemeData theme) {
    final labelWidget = selectionStyle == SelectionStyle.gradient
        ? ShaderMask(
            shaderCallback: (isSelected
                    ? theme.selectedItemGradient
                    : theme.unselectedItemGradient)
                .defaultShader,
            child:
                Text(label ?? '', style: const TextStyle(color: Colors.white)),
          )
        : Text(
            label ?? '',
            style: TextStyle(
              color: isSelected
                  ? theme.selectedItemGradient.colors.first
                  : theme.unselectedItemGradient.colors.first,
            ),
          );

    return isIndicatorStyle
        ? Opacity(
            opacity: isSelected ? 1 : 0.6,
            child: labelWidget,
          )
        : labelWidget;
  }

  Widget _getThemedIcon(SnakeBottomBarThemeData theme) {
    final iconWidget = selectionStyle == SelectionStyle.gradient
        ? ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (isSelected
                    ? theme.selectedItemGradient
                    : theme.unselectedItemGradient)
                .defaultShader,
            child: icon,
          )
        : IconTheme(
            data: IconThemeData(
              color: isSelected
                  ? theme.selectedItemGradient.colors.first
                  : theme.unselectedItemGradient.colors.first,
            ),
            child: icon,
          );
    return isIndicatorStyle
        ? Opacity(
            opacity: isSelected ? 1 : 0.6,
            child: iconWidget,
          )
        : iconWidget;
  }
}

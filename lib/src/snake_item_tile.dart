import 'package:flutter/material.dart';
import 'selection_notifier.dart';

class SnakeItemTile extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final bool selectedLabelVisible;
  final bool unselectedLabelVisible;
  final int position;
  final Gradient selectedGradient;
  final Gradient unSelectedGradient;
  final SelectionNotifier notifier;
  final SelectionStyle selectionStyle;

  SnakeItemTile(
    this.icon,
    this.label,
    this.selectedLabelVisible,
    this.unselectedLabelVisible,
    this.position,
    this.selectedGradient,
    this.unSelectedGradient,
    this.notifier,
    this.selectionStyle,
  );

  @override
  Widget build(BuildContext context) {
    final bool isSelected = notifier.currentIndex == position;

    return Expanded(
      child: GestureDetector(
        onTap: () => notifier.selectIndex(position),
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraint) {
                if (selectedLabelVisible && unselectedLabelVisible) {
                  return _getLabeledItem(isSelected);
                } else if (selectedLabelVisible) {
                  return isSelected
                      ? _getLabeledItem(isSelected)
                      : _getThemedIcon(isSelected);
                } else if (unselectedLabelVisible) {
                  return isSelected
                      ? _getThemedIcon(isSelected)
                      : _getLabeledItem(isSelected);
                } else {
                  return _getThemedIcon(isSelected);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _getLabeledItem(isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getThemedIcon(isSelected),
        SizedBox(height: 1),
        _getThemedTitle(isSelected),
      ],
    );
  }

  Widget _getThemedTitle(isSelected) {
    return selectionStyle == SelectionStyle.color
        ? ShaderMask(
            child: DefaultTextStyle.merge(
                child: label, style: TextStyle(color: Colors.white)),
            shaderCallback: (bounds) => (isSelected
                    ? selectedGradient
                    : unSelectedGradient)
                .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          )
        : Opacity(
            opacity: isSelected ? 1 : 0.6,
            child: ShaderMask(
                child: label,
                shaderCallback: (bounds) =>
                    (isSelected ? selectedGradient : unSelectedGradient)
                        .createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height))),
          );
  }

  Widget _getThemedIcon(isSelected) {
    return selectionStyle == SelectionStyle.color
        ? ShaderMask(
            blendMode: BlendMode.srcIn,
            child: icon,
            shaderCallback: (Rect bounds) => (isSelected
                    ? selectedGradient
                    : unSelectedGradient)
                .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          )
        : Opacity(
            opacity: isSelected ? 1 : 0.6,
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              child: icon,
              shaderCallback: (Rect bounds) => unSelectedGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
            ),
          );
  }
}

enum SelectionStyle {
  color,
  opacity,
}
